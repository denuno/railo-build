package runwar;

import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;

public class Stop {

    public static void main(String[] args) throws Exception {
    	int socketNumber = Integer.parseInt(args[0]);
        Socket s = new Socket(InetAddress.getByName("127.0.0.1"), socketNumber);
        OutputStream out = s.getOutputStream();
        System.out.println("*** sending jetty stop request to socket : " + socketNumber);
        out.write(("\r\n").getBytes());
        out.flush();
        s.close();
        System.exit(0);
    }

}
