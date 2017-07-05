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
<%@ page import="com.jsp.vcs.inout" %>
<%
	out.clear();
%>
<%
	String actualFileComparePath = "C:/Users/LonelyTomb/IdeaProjects/JS_TEST/web/upload/" + session.getAttribute("downloadFile");
	String expectedFileComparePath = "C:/Users/LonelyTomb/IdeaProjects/JS_TEST/web/" + session.getAttribute("downloadFile");

// This will compare any types of files- here video.Eg-Video
	FileCompareUtility fileCompareUtil = new FileCompareUtility();
	Boolean status = fileCompareUtil.compare2Files(actualFileComparePath, expectedFileComparePath);
	if (status) {
		int cnt = (int) session.getAttribute("count") - 2;
		inout.changeCnt(cnt);
		ProgressiveVC((int[][][]) session.getAttribute("Shares"));
	}else{
		request.getSession().invalidate();
		response.sendRedirect("http://localhost:8080/invalid");
	}
%>
<html>
<head>
	<link rel="stylesheet" href="css/materialize.min.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script src="js/materialize.min.js"></script>
	<title>Title</title>
</head>
<body>
<nav>
	<div class="nav-wrapper">
		<a href="#" class="brand-logo center">A SECURE OTP SYSTEM USING VISUAL CRYPTOGRAPHY</a>

	</div>
</nav>
<main>
	<div class="container">
		<div class="card container">
			<div class="card-title"></div>
			<div class="card-content">
				<div class="card-image">
					<img src="output<%=session.getAttribute("count")%>.jpg" alt="">
				</div>
			</div>

			<div class="card-action">
				<form action="validation.jsp" method="post">
					<div class="row">
						<div class="input-field">
							<input type="text" id="otp" class="validate" name="otp">
							<label for="otp"> Enter Displayed OTP</label>
						</div>
					</div>
					<button class="btn waves-ripple">Submit</button>
				</form>
			</div>
		</div>
	</div>
</main>
</body>
</html>
