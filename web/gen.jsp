<%--
  Created by IntelliJ IDEA.
  User: LonelyTomb
  Date: 6/30/2017
  Time: 12:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jsp.totp.TOTP" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.*,java.awt.image.BufferedImage" %>
<%@page import="com.jsp.vcs.alter" %>
<%@page import="com.jsp.vcs.Picture" %>
<%@page import="com.jsp.vcs.inout" %>
<%@ page import="static com.jsp.vcs.inout.loadImage" %>
<%@ page import="static com.jsp.vcs.inout.saveImage" %>
<%@ page import="static com.jsp.vcs.inout.encrypt" %>
<%@ page import="static com.jsp.vcs.inout.*" %>
<%@ page import="java.awt.image.renderable.RenderedImageFactory" %>
<%@ page import="com.jsp.vcs.FileCompareUtility" %>

<%!
    public static String pathFile = "C:\\Users\\LonelyTomb\\IdeaProjects\\JS_TEST\\web\\";
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
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
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
    createimage(a,"text");

    long startTime = System.currentTimeMillis();

    BufferedImage img = loadImage(pathFile+"text.gif");
//    out.println(img.getColorModel() + "color model :");
    int Nshares;
    int w = img.getWidth();
    int h = img.getHeight();
    img = com.jsp.vcs.alter.monochrome(img);

    saveImage(img, "monochrome_image", 1);
    int[][] pixels = encrypt(img);
//    out.println("Hello ! Welcome to Progressive Visual Cryptography\n Enter the number of shares :");
    Nshares =3;
    int[][][] Shares = new int[Nshares][w][h];
    Shares = makeShares(pixels, Nshares,"shares");

    ProgressiveVC(Shares);

    String actualFileComparePath = "C:\\wamp\\www\\PVC\\Share1.jpg";
    String expectedFileComparePath = "C:\\wamp\\www\\PVC\\Share2CC.jpg";

// This will compare any types of files- here video.Eg-Video
    FileCompareUtility fileCompareUtil = new FileCompareUtility();
    Boolean tes = fileCompareUtil.compare2Files(actualFileComparePath, expectedFileComparePath);
    out.println(tes);

//    long endTime = System.currentTimeMillis();
//    System.out.println("Total elapsed time in execution is:" + (endTime - startTime));
%>

<html>
<head>
    <title>$Title$</title>
</head>
<body>
<form action=""></form>
<p>YOUr OTP is
    <%=a%>
</p>
</body>
</html>
