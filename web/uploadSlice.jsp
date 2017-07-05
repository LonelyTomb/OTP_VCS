<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 7/3/2017
  Time: 9:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.99.0/css/materialize.min.css">
	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.99.0/js/materialize.min.js"></script>
	<title>Upload Slice</title>
</head>
<body>
<nav>
	<div class="nav-wrapper">
		<a class="brand-logo center">A SECURE OTP SYSTEM USING VISUAL ENCRYPTION</a>

	</div>
</nav>
<div class="container">
	<form action="FileUploadServlet" method="post" enctype="multipart/form-data">
		<div class="row">
			<div class="file-field input-field">
				<p>Pleas Upload downloaded Slice</p>
				<div class="btn">
					<span>Choose Slice</span>
					<input type="file" name="file">
				</div>
				<div class="file-path-wrapper">
					<input class="file-path validate" type="text" placeholder="Upload Share">
				</div>

			</div>
			<button type="submit" class="wave waves-ripple btn">Upload</button>
		</div>
	</form>
</div>
</body>
</html>
