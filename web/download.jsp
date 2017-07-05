<%@ page session="true" language="java" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>


<%
out.clear();

	// you  can get your base and parent from the database
	String filename = session.getAttribute("downloadFile").toString();
// you can  write http://localhost
	String base="e1";

	String filepath="C:/Users/LonelyTomb/IdeaProjects/JS_TEST/web/";

	BufferedInputStream buf = null;
	ServletOutputStream myOut = null;

	try {

		myOut = response.getOutputStream();
		File myfile = new File(filepath + filename);

		//set response headers
		response.setContentType("image/jpeg");

		response.addHeader(
				"Content-Disposition", "attachment; filename=" + filename);

		response.setContentLength((int) myfile.length());

		FileInputStream input = new FileInputStream(myfile);
		buf = new BufferedInputStream(input);
		int readBytes = 0;

		//read from the file; write to the ServletOutputStream
		while ((readBytes = buf.read()) != -1)
			myOut.write(readBytes);

	} catch (IOException ioe) {

		throw new ServletException(ioe.getMessage());

	} finally {

		//close the input/output streams
		if (myOut != null)
			myOut.close();
		if (buf != null)
			buf.close();

	}

out.clear();
%>
