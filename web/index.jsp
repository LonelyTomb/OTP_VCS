<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 6/30/2017
  Time: 12:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jsp.totp.TOTP" %>
<%@ page import="com.jsp.vcs.ExtendedVCS" %>
<%@ page import="com.jsp.vcs.PixelVCS" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.*,java.awt.image.BufferedImage" %>

<%!
    public static void createimage(String text, String filename) {
        BufferedImage img = new BufferedImage(400, 80, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = img.createGraphics();
        Font font = new Font("Arial", Font.PLAIN, 48);
        g2d.setFont(font);
        FontMetrics fm = g2d.getFontMetrics();
        int width = 400;
        int height = 80;
        if (text.equals("")) {
        width = fm.stringWidth(text);
        height = fm.getHeight();
        }
        g2d.dispose();

        img = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        g2d = img.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_ALPHA_INTERPOLATION, RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_COLOR_RENDERING, RenderingHints.VALUE_COLOR_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
        g2d.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g2d.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
        g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL, RenderingHints.VALUE_STROKE_PURE);
        g2d.setFont(font);
        fm = g2d.getFontMetrics();
        g2d.setColor(Color.WHITE);
        g2d.drawString(text, 0, fm.getAscent());
        g2d.dispose();
        try {
            ImageIO.write(img, "jpeg", new File("C:\\Users\\LonelyTomb\\IdeaProjects\\JS_TEST\\" + filename + ".jpeg"));
        } catch (IOException ex) {
            ex.printStackTrace();
        }


    }
%>
<%

    String[] innocentFiles = new String[2];

    BufferedImage secretImage = null;
    boolean fileFound;

    try {
        createimage(new TOTP().getTOTP(), "Text");
        secretImage = ImageIO.read(new File("C:\\Users\\LonelyTomb\\IdeaProjects\\JS_TEST\\Text.jpeg"));

        fileFound = true;
    } catch (IOException e) {
        out.println("Error:  The file you tried to encrypt does not exist." + e.getMessage());
        fileFound = false;
    }

%>

<html>
<head>
    <title>$Title$</title>
</head>
<body>
<form action=""></form>
<p>YOUr OTP is
</p>
</body>
</html>
