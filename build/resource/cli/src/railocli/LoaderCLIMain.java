package railocli;

import java.io.File;
import java.io.FileOutputStream;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.FilenameFilter;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;

public class LoaderCLIMain {

	private static String ZIP_PATH = "libs.zip";
	private static final int KB = 1024;

	public static void main(String[] args) throws Throwable {
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		File currentDir = new File(LoaderCLIMain.class.getProtectionDomain().getCodeSource().getLocation().getPath()).getParentFile();
		System.out.println(currentDir.getPath());
		File libDir=new File(currentDir,"lib").getCanonicalFile();
		System.out.println(libDir);

		File libsFile = new File(currentDir.getCanonicalPath() + "/" + ZIP_PATH);

		if (!libDir.exists()) {
			libDir.mkdir();
			URL resource = classLoader.getResource(ZIP_PATH);
			if (resource == null) {
				System.err.println("Could not find the " + ZIP_PATH + " on classpath!");
				System.exit(1);
			}
			System.out.println("Extracting " + ZIP_PATH + " to " + libsFile + " ...");
			//writeStreamTo(resource.openStream(), new FileOutputStream(libsFile), 8 * KB);

			System.out.println("Extracting " + ZIP_PATH);

			try {

				BufferedInputStream bis = new BufferedInputStream(resource.openStream());
				JarInputStream jis = new JarInputStream(bis);
				JarEntry je = null;

				while ((je = jis.getNextJarEntry()) != null) {
					java.io.File f = new java.io.File(libDir.toString() + java.io.File.separator + je.getName());
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

		
        File[] children = libDir.listFiles(new ExtFilter());
        if(children.length<2) {
        	libDir=new File(libDir,"lib");
        	 children = libDir.listFiles(new ExtFilter());
        }
        
        URL[] urls = new URL[children.length];
        System.out.println("Loading Jars");
        for(int i=0;i<children.length;i++){
        	urls[i]=new URL ("jar:file://" + children[i] + "!/");
        	System.out.println("- "+urls[i]);
        }
        System.out.println();
        URLClassLoader cl = new URLClassLoader(urls,ClassLoader.getSystemClassLoader());
		//Thread.currentThread().setContextClassLoader(cl);
        Class cli = cl.loadClass("railocli.CLIMain");
        Method main = cli.getMethod("main",new Class[]{String[].class});
		try{
        	main.invoke(null, new Object[]{args});
		} catch (Exception e) {
			e.getCause().printStackTrace();
		}
        
        
	}
	

	public static class ExtFilter implements FilenameFilter {
		
		private String ext=".jar";
		public boolean accept(File dir, String name) {
			return name.toLowerCase().endsWith(ext);
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
