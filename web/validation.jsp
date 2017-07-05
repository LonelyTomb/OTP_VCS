<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 7/5/2017
  Time: 6:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
	String message = "<h2>Incorrect OTP. </h2><a class='btn btn-flat' href='index.jsp'>Please Try Again</a>";
	String title = "Invalid OTP";
	if (Integer.parseInt(request.getParameter("otp")) == Integer.parseInt(session.getAttribute("OTP").toString())) {
		message = "<h2>OTP is Valid.</h2>";
		title = "Valid OTP";

	}
%>
<html>
<head>
	<title><%=title%></title>
	<link rel="stylesheet" href="css/materialize.min.css">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script src="js/materialize.min.js"></script>

</head>
<body>
<nav>
	<div class="nav-wrapper">
		<a href="#" class="brand-logo center">A SECURE OTP SYSTEM USING VISUAL CRYPTOGRAPHY</a>

	</div>
</nav>
<div class="container">
	<div class="card-panel">
	<%=message%>
	</div>
</div>
</body>
</html>
