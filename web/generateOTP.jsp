<%@ page session="true" language="java" %>
<%@ page import="java.awt.*" %>
<%@ page import="com.jsp.totp.TOTP" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="static com.jsp.vcs.inout.makeShares" %>
<%@ page import="static com.jsp.vcs.inout.encrypt" %>
<%@ page import="static com.jsp.vcs.inout.saveImage" %>

<%@ page import="static com.jsp.vcs.inout.*" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.DataInputStream" %><%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 7/3/2017
  Time: 7:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

%>
<%!
    public static String pathFile = "C:\\Users\\LonelyTomb\\IdeaProjects\\JS_TEST\\web\\";

%>
<%
    HttpSession sessions = request.getSession();
    if (request.getParameter("username") != null) {
        sessions.setAttribute("username", request.getParameter("username"));
    }
%>
<%!

    public static void createimage(String text, String filename) {
        BufferedImage img = new BufferedImage(200, 200, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = img.createGraphics();
        Font font = new Font("Arial", Font.PLAIN, 48);
        g2d.setFont(font);
        FontMetrics fm = g2d.getFontMetrics();
        int width = 200;
        int height = 200;
//        if (!text.equals("")) {
//            width = fm.stringWidth(text);
//            height = fm.getHeight();
//        }
        g2d.dispose();

        img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        g2d = img.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
        g2d.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
        g2d.setFont(font);
        fm = g2d.getFontMetrics();
        g2d.setColor(Color.WHITE);
        g2d.setBackground(Color.BLACK);

        g2d.drawString(text, 0, fm.getAscent());
        g2d.dispose();
        try {
            ImageIO.write(img, "gif", new File(pathFile + filename + ".gif"));


        } catch (IOException ex) {
            ex.printStackTrace();
        }


    }
%>
<%!String a = new TOTP().getTOTP();%>

<%

    createimage(a, sessions.getAttribute("username").toString());

    long startTime = System.currentTimeMillis();

    if (sessions.getAttribute("Shares") == null) {

        BufferedImage img = loadImage(pathFile + sessions.getAttribute("username").toString() + ".gif");
//    out.println(img.getColorModel() + "color model :");
        int Nshares;
        int w = img.getWidth();
        int h = img.getHeight();
        img = com.jsp.vcs.alter.monochrome(img);

        saveImage(img, "monochrome_image", 1);
        int[][] pixels = encrypt(img);
//    out.println("Hello ! Welcome to Progressive Visual Cryptography\n Enter the number of shares :");
        Nshares = 3;
        int[][][] Shares = new int[Nshares][w][h];
        Shares = makeShares(pixels, Nshares, sessions.getAttribute("username").toString());


        session.setAttribute("Shares", Shares);
        sessions.setAttribute("downloadFile", request.getParameter("username") + getCount() + ".jpg");
    }
%>

<%
	out.clear();
%>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.99.0/css/materialize.min.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.99.0/js/materialize.min.js"></script>
    <title>Title</title>
</head>
<body>
<nav>
    <div class="nav-wrapper">
        <a href="share<%=getCount()%>.jpg" class="brand-logo center">A SECURE OTP SYSTEM USING VISUAL ENCRYPTION</a>

    </div>
</nav>
<main>
    <div class="container">
        <div class="card-panel">
            <p>OTP has been generated and encrypted</p>
            <a href="download.jsp" download class="waves waves-ripple btn">Download
                Slice</a>
            <a href="uploadSlice.jsp" class="waves waves-ripple btn">To Upload Slice Page</a>

        </div>
    </div>
</main>
</body>
</html>
