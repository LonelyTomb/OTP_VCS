<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 7/3/2017
  Time: 7:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="css/materialize.min.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/materialize.min.js"></script>
    <title>Home Page</title>
</head>
<body>
<nav>
    <div class="nav-wrapper">
        <a href="#" class="brand-logo center">A SECURE OTP SYSTEM USING VISUAL CRYPTOGRAPHY</a>

    </div>
</nav>
<main>

<div class="container">
    <div class="card ">
        <div class="card-title">
            <h2 class="center">Log In</h2>
        </div>
        <div class="card-content container">
            <form action="generateOTP.jsp" method="post" id="form1">
                <div class="row">
                    <div class="input-field">
                        <input autocomplete="off" id="username" type="text" class="validate" name="username">
                        <label for="username">UserName</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field">
                        <input autocomplete="off" id="password" type="password" class="validate">
                        <label for="password">Password</label>
                    </div>
                </div>

            </form>
        </div>
        <div class="card-action">
            <div class="row">
                <div class="input-field">
                    <button type="submit" class="btn waves-ripple red" form="form1">Generate OTP</button>
                </div>
            </div>
        </div>
    </div>
</div>
</main>
</body>
</html>
