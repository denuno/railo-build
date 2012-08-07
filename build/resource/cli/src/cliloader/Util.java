package cliloader;
import java.io.*;
import java.util.jar.*;
import java.util.zip.GZIPInputStream;

public class Util {

  public static void unpack(File inFile) {
    
    String inName = inFile.getPath();
    String outName;
    if (inName.endsWith(".pack.gz")) {
      outName = inName.substring(0, inName.length()-8);
    }
    else if (inName.endsWith(".pack")) {
      outName = inName.substring(0, inName.length()-5);
    }
    else {
      outName = inName + ".unpacked";
    }
    
    JarOutputStream out = null;
    InputStream in = null;
    try {
      Pack200.Unpacker unpacker = Pack200.newUnpacker();
      out = new JarOutputStream(new FileOutputStream(outName));
      in = new FileInputStream(inName);
      if (inName.endsWith(".gz")) in = new GZIPInputStream(in);
      unpacker.unpack(in, out);
    } 
    catch (IOException ex) {
      ex.printStackTrace();
    }
    finally {
      if (out != null) {
        try {
          out.close();
        } 
        catch (IOException ex) {
          System.err.println("Error closing file: " + ex.getMessage());
        }
      }
    }
  }
}
