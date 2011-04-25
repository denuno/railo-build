package runwar;

import java.io.File;
import java.io.FileOutputStream;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;
import java.util.Timer;
import java.util.TimerTask;
import java.net.*;

import org.mortbay.jetty.runner.Runner;

/**
 * A bootstrap class for starting Jetty Runner using an embedded war
 * 
 * @version $Revision$
 */
public final class RunEmbeddedWar {
	private static String WAR_POSTFIX = ".war";
	private static String PORT = "8088";
	private static String WAR_NAME = "cfdistro";
	private static String WAR_FILENAME = WAR_NAME + WAR_POSTFIX;
	private static final int KB = 1024;

	public RunEmbeddedWar(int seconds) {
			Timer timer = new Timer();
			timer.schedule(this.new OpenBrowserTask(), seconds * 1000);
	  }


	public static void main(String[] args) throws Exception {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

		String sConfigFile = "runwar.properties";
		InputStream in = classLoader.getResourceAsStream(sConfigFile);
		if (in == null) {
			// File not found! (Manage the problem)
		}
		Properties props = new java.util.Properties();
		props.load(in);
		WAR_NAME = props.getProperty("war.name");
		if(props.getProperty("runwar.port") != null) {			
			PORT = props.getProperty("runwar.port");
		}
		WAR_POSTFIX = ".war";
		WAR_FILENAME = WAR_NAME + WAR_POSTFIX;
		System.out.println(props.toString());
		System.out.println("Starting...");

		// File warFile = File.createTempFile(WAR_NAME + "-", WAR_POSTFIX);
		File currentDir = new File(".");
		File warFile = new File(currentDir.getCanonicalPath() + "/" + WAR_FILENAME);
		File warDir = new File(currentDir.getCanonicalPath() + "/" + WAR_NAME);

		if (!warDir.exists()) {
			warDir.mkdir();
			URL resource = classLoader.getResource(WAR_FILENAME);
			if (resource == null) {
				System.err.println("Could not find the " + WAR_FILENAME + " on classpath!");
				System.exit(1);
			}
			System.out.println("Extracting " + WAR_FILENAME + " to " + warFile + " ...");
			writeStreamTo(resource.openStream(), new FileOutputStream(warFile), 8 * KB);

			System.out.println("Extracted " + WAR_FILENAME);

			try {

				BufferedInputStream bis = new BufferedInputStream(classLoader.getResourceAsStream(WAR_FILENAME));
				JarInputStream jis = new JarInputStream(bis);
				JarEntry je = null;

				while ((je = jis.getNextJarEntry()) != null) {
					java.io.File f = new java.io.File(warDir.toString() + java.io.File.separator + je.getName());
					if (je.isDirectory()) {
						f.mkdir();
						continue;
					}
					File parentDir = new File(f.getParent());
					if (!parentDir.exists()) {
						parentDir.mkdir();
					}
					writeStreamTo(jis, new FileOutputStream(f), 8 * KB);
				}
				bis.close();

			} catch (Exception exc) {
				exc.printStackTrace();
			}
		}

		System.out.println("Launching Jetty Runner...");

		List<String> argsList = new ArrayList<String>();
		if (args != null) {
			argsList.addAll(Arrays.asList(args));
		}
		argsList.add("--port");
		argsList.add(PORT);
		argsList.add(warDir.getCanonicalPath());
		argsList.add("../");
		
		if(props.getProperty("open.url") != null) {
			new RunEmbeddedWar(3);
		}
		Runner.main(argsList.toArray(new String[argsList.size()]));
		System.exit(0);
	}

	  class OpenBrowserTask extends TimerTask {
		    public void run() {
				ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
				String sConfigFile = "runwar.properties";
				InputStream in = classLoader.getResourceAsStream(sConfigFile);
				Properties props = new java.util.Properties();
				Boolean connected = false;
				try{					
					props.load(in);
					System.out.println("Waiting for server...");
					while(!connected) {
						try {
						Socket socket = new Socket(InetAddress.getLocalHost(), Integer.parseInt(PORT));
						Thread.currentThread().sleep(3000);
						connected = true;
						} catch (Exception any) {
							connected = false;
						}												
					}					
					System.out.println("Opening browser to..." + props.getProperty("open.url"));
					BrowserOpener.openURL(props.getProperty("open.url").trim());
				} catch (Exception e) {
					e.printStackTrace();
				}
	    	}
	  }	
	
	public static int writeStreamTo(final InputStream input, final OutputStream output, int bufferSize)
			throws IOException {
		int available = Math.min(input.available(), 256 * KB);
		byte[] buffer = new byte[Math.max(bufferSize, available)];
		int answer = 0;
		int count = input.read(buffer);
		while (count >= 0) {
			output.write(buffer, 0, count);
			answer += count;
			count = input.read(buffer);
		}
		return answer;
	}
}
