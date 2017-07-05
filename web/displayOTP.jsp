<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 7/5/2017
  Time: 4:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jsp.vcs.FileCompareUtility" %>
<%@ page import="static com.jsp.vcs.inout.ProgressiveVC" %>
<%
	out.clear();
%>
<%
	HttpSession sessions = request.getSession();
	String actualFileComparePath = "C:/Users/LonelyTomb/IdeaProjects/JS_TEST/web/upload/"+sessions.getAttribute("downloadFile");
	String expectedFileComparePath = "C:/Users/LonelyTomb/IdeaProjects/JS_TEST/web/"+sessions.getAttribute("downloadFile");

// This will compare any types of files- here video.Eg-Video
	FileCompareUtility fileCompareUtil = new FileCompareUtility();
	Boolean status = fileCompareUtil.compare2Files(actualFileComparePath, expectedFileComparePath);
	if(status){
		ProgressiveVC((int[][][]) sessions.getAttribute("Shares"));
	}
%>
<html>
<head>
	<title></title>
</head>
<body>
<%=status%>
</body>
</html>
