package runwar;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;

import org.eclipse.jetty.server.handler.ContextHandlerCollection;
import org.eclipse.jetty.util.resource.Resource;
import org.eclipse.jetty.webapp.WebAppContext;

public class CFMLContext extends WebAppContext {
	private String _skinURI = "/mxunit";
	private String _srcDir = "/workspace/mxunit-cfdistro/src";
	private Resource _srcDirResource;

	/**
	 * Standard constructor; passed a path or URL for a war (or exploded war
	 * directory).
	 * 
	 * @param contexts
	 * 
	 * @param contextPath
	 */
	public CFMLContext(ContextHandlerCollection contexts, String war, String contextPath) {
		super(contexts, war, contextPath);
		try {
			_srcDirResource = Resource.newResource(_srcDir);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// public boolean isParentLoaderPriority() {
	// return true;
	// }

	// public Resource getWebInf() {
	// return _webInf;
	// }

	public Resource getResource(String contextPath) {
		try {
			 System.out.println("requested:"+contextPath);
			File reqFile = new File(_srcDir + contextPath);
			 System.out.println("requested =="+reqFile.getAbsolutePath() + " exists:" + reqFile.exists());
			if (reqFile.exists() && !contextPath.equals("/")) {
				//System.out.println("returning:" + _srcDir + contextPath);
				return _srcDirResource.addPath(contextPath);
			}

			return super.getResource(contextPath);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
