package runwar;

import java.io.IOException;
import java.io.File;

import java.io.PrintStream;
import java.io.FileOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletConfig;

import org.eclipse.jetty.server.Connector;
import org.eclipse.jetty.server.Handler;
import org.eclipse.jetty.server.NCSARequestLog;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.bio.SocketConnector;
import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.server.handler.DefaultHandler;
import org.eclipse.jetty.server.handler.HandlerCollection;
import org.eclipse.jetty.server.handler.RequestLogHandler;
import org.eclipse.jetty.server.nio.SelectChannelConnector;
import org.eclipse.jetty.server.Connector;
//import org.eclipse.jetty.server.handler.ContextHandler.Context;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.util.RolloverFileOutputStream;
import org.eclipse.jetty.webapp.WebAppContext;

import runwar.BrowserOpener;

//import railo.loader.engine.CFMLEngine;

public class Start {

    private static Server server;
    public static final String[] __plusConfigurationClasses = new String[] {
        org.eclipse.jetty.webapp.WebInfConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.webapp.WebXmlConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.webapp.MetaInfConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.webapp.FragmentConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.plus.webapp.EnvConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.plus.webapp.Configuration.class.getCanonicalName(),
        org.eclipse.jetty.webapp.JettyWebXmlConfiguration.class.getCanonicalName(),
        org.eclipse.jetty.webapp.TagLibConfiguration.class.getCanonicalName() 
        };

    
	public static void main(String[] args) throws Exception {
		PrintStream stdout = null;
		String warPath = new File(args[0]).toURI().toURL().toString();
		String contextPath = args[1];
		int portNumber = Integer.parseInt(args[2]);
		int socketNumber = Integer.parseInt(args[3]);
		String logDir = args[4];
		
		try {
			PrintStream out = new PrintStream(new RolloverFileOutputStream(logDir + "runner.log.txt",true,-1));
			//redirect output
			System.setOut ( out );
			System.setErr ( out );
		} catch (Exception e) {
			// Sigh. Couldn't open the file.
			System.out.println("Redirect:  Unable to open output file!");
		}

		if(!new File(args[0]).exists()) {
			System.out.println("No war file "+new File(args[4]).toString());
			System.exit(1);
		}

		server = new Server();
		System.out.println("warpath: " + warPath);
		System.out.println("contextPath: " + contextPath);
		System.out.println("Port: " + portNumber);
		System.out.println("Stop Socket: " + socketNumber);
		System.out.println("Log Directory: " + logDir);
		System.out.println("********************************");
//		runwar.BrowserOpener.openURL("http://127.0.0.1:8080/blah/index.cfm");
		  Connector connector=new SelectChannelConnector();
		//SocketConnector connector = new SocketConnector();
		connector.setPort(portNumber);
		server.setConnectors(new Connector[] { connector });

        HandlerCollection handlers = (HandlerCollection) server.getChildHandlerByClass(HandlerCollection.class);
        if (handlers == null)
        {
            handlers = new HandlerCollection();
            server.setHandler(handlers);
        }        
        ContextHandlerCollection contexts = (ContextHandlerCollection) handlers.getChildHandlerByClass(ContextHandlerCollection.class);
        if (contexts == null)
        {
            contexts = new ContextHandlerCollection();
        }
        RequestLogHandler requestLogHandler = new RequestLogHandler();

        NCSARequestLog requestLog = new NCSARequestLog(logDir + "runwar-yyyy_mm_dd.request.log");
        requestLog.setRetainDays(90);
        requestLog.setAppend(true);
        requestLog.setExtended(true);
        requestLog.setLogTimeZone("GMT");
        requestLogHandler.setRequestLog(requestLog);		
		
		WebAppContext context = new WebAppContext(contexts,warPath,contextPath);
        context.setConfigurationClasses(__plusConfigurationClasses);
//		context.setContextPath(contextPath);
		//context.setResourceBase(warPath);
//		context.setWar(warPath);
		//context.setServer(server);
		//context.setResourceAlias("/index.cfm","file:///workspace/cfdistro/build/index.html");
		//server.setHandler(context);
        Thread monitor = new MonitorThread(stdout,socketNumber);

        handlers.setHandlers(new Handler[]{contexts,new DefaultHandler(),requestLogHandler});
        
        System.err.println(Arrays.asList(contexts.getHandlers()));
        
        server.setHandler(handlers);
        server.setStopAtShutdown(true);
        server.setSendServerVersion(true);
        
        monitor.start();
        server.start();
        server.join();
        System.exit(0);
	}


    private static class MonitorThread extends Thread {

        private ServerSocket socket;
        private PrintStream stdout;
        private int socketNumber;

        public MonitorThread(PrintStream stdoutIn, int socketNumber) {
            stdout = stdoutIn;
        	setDaemon(true);
            setName("StopMonitor");
            this.socketNumber = socketNumber;
            try {
                socket = new ServerSocket(socketNumber, 1, InetAddress.getByName("127.0.0.1"));
            } catch(Exception e) {
                throw new RuntimeException(e);
            }
        }

        @Override
        public void run() {
    		System.out.println("***********************************");
            System.out.println("*** starting jetty 'stop' listener thread - Host: 127.0.0.1 - Socket: " + this.socketNumber);
    		System.out.println("***********************************");
            Socket accept;
            try {
                accept = socket.accept();
                BufferedReader reader = new BufferedReader(new InputStreamReader(accept.getInputStream()));
                reader.readLine();
        		System.out.println("***********************************");
                System.out.println("*** stopping jetty embedded server");
        		System.out.println("***********************************");
                server.stop();
                accept.close();
                socket.close();
            } catch(Exception e) {
                throw new RuntimeException(e);
            }
			try {
				stdout.close();
			} catch (Exception e) {
				System.out.println("Redirect:  Unable to close this log file!");
			}

        }
    }
    
    
//    public static class HelloServlet extends HttpServlet
//    {
//        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//        {
//            response.setContentType("text/html");
//            response.setStatus(HttpServletResponse.SC_OK);
//            response.getWriter().println("<h1>Hello SimpleServlet</h1>");
//        }
//    }
}
