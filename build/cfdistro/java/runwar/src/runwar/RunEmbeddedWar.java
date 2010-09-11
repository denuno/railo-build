package runwar;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.mortbay.jetty.runner.Runner;

/**
 * A bootstrap class for starting Jetty Runner using an embedded war
 *
 * @version $Revision$
 */
public final class RunEmbeddedWar {
    private static String WAR_POSTFIX = ".war";
    private static String WAR_NAME = "cfdistro";
    private static String WAR_FILENAME = WAR_NAME + WAR_POSTFIX;
    private static final int KB = 1024;

    public static void main(String[] args) throws Exception {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

        String sConfigFile = "runwar.properties";    	
    	InputStream in = classLoader.getResourceAsStream(sConfigFile);
    	if (in == null) {
    		//File not found! (Manage the problem)
    	}
    	Properties props = new java.util.Properties();
    	props.load(in);
    	WAR_NAME = props.getProperty("war.name");
    	WAR_POSTFIX = ".war";
    	WAR_FILENAME = WAR_NAME + WAR_POSTFIX;
        System.out.println(props.toString());
    	System.out.println("Welcome to Railo!");        

        URL resource = classLoader.getResource(WAR_FILENAME);
        if (resource == null) {
            System.err.println("Could not find the " + WAR_FILENAME + " on classpath!");
            System.exit(1);
        }

        File warFile = File.createTempFile(WAR_NAME + "-", WAR_POSTFIX);
        System.out.println("Extracting " + WAR_FILENAME + " to " + warFile + " ...");

        writeStreamTo(resource.openStream(), new FileOutputStream(warFile), 8 * KB);

        System.out.println("Extracted " + WAR_FILENAME);
        System.out.println("Launching Jetty Runner...");

        List<String> argsList = new ArrayList<String>();
        if (args != null) {
            argsList.addAll(Arrays.asList(args));
        }
        argsList.add(warFile.getCanonicalPath());
        argsList.add("../");
        Runner.main(argsList.toArray(new String[argsList.size()]));
        System.exit(0);
    }

    public static int writeStreamTo(final InputStream input, final OutputStream output, int bufferSize) throws IOException {
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
