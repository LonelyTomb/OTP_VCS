package com.jsp.vcs;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

/**
 * Created by LonelyTomb on 7/1/2017.
 */
public class Encrypt {
    public static void createimage(String text, String filename) {
        BufferedImage img = new BufferedImage(400, 80, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = img.createGraphics();
        Font font = new Font("Arial", Font.PLAIN, 48);
        g2d.setFont(font);
        FontMetrics fm = g2d.getFontMetrics();
        int width = 400;
        int height = 80;
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
            ImageIO.write(img, "jpeg", new File(filename + ".jpeg"));
        } catch (IOException ex) {
            ex.printStackTrace();
        }


    }

    public static void EncryptImage(String otp) {
        String secretFile;
        String[] innocentFiles = new String[2];

        BufferedImage secretImage = null;
        boolean fileFound;

        try {
            createimage(otp, "Text");
            secretImage = ImageIO.read(new File("Text.jpeg"));

            fileFound = true;
        } catch (IOException e) {
            System.out.println("Error:  The file you tried to encrypt does not exist." + e.getMessage());
            fileFound = false;
        }

        if (fileFound) {
            //get name of innocent 1
            //get name of innocent 2
            for (int i = 0; i < 2; i++) {
                createimage("", "sh-0" + i);
                innocentFiles[i] = "sh-0" + i + ".jpeg";
            }
            BufferedImage[] innocentShares = new BufferedImage[2];
            for (int i = 0; i < 2; i++) {
                try {
                    innocentShares[i] = ImageIO.read(new File(innocentFiles[i]));
                    fileFound = true;
                } catch (IOException e) {
                    String errorString = "Error:  The file \"" + innocentFiles[i] + "\" does not exist.";
                    fileFound = false;
                }
            }

            //if all files found
            if (fileFound) {
                //pass to extendedvcs obj
                ExtendedVCS myEVCS = new ExtendedVCS(secretImage, innocentShares);
                //encrypt
                myEVCS.encryptImage();

                //get rgbs of new innocent files
                int[][] newInnocentRGB = myEVCS.getRGBPixelsForShares();

                //print to image files

                String folderName = "";

                String[] shareFiles = new String[2];
                for (int i = 0; i < 2; i++) {

                    shareFiles[i] = folderName + "/share" + (i + 1) + ".png";

                }

                for (int i = 0; i < 2; i++) {
                    try {
                        //Takes the pixel array and creates a new buffered image
                        BufferedImage tempShare = new BufferedImage(myEVCS.getImgWidth(), myEVCS.getImgHeight(),
                                BufferedImage.TYPE_INT_ARGB);
                        tempShare.setRGB(0, 0, myEVCS.getImgWidth(), myEVCS.getImgHeight(),
                                newInnocentRGB[i], 0, myEVCS.getImgWidth());

                        //Creates the file name of the new image
                        File tempOutput = new File(shareFiles[i]);

                        //Writes the buffered image to a png file
                        ImageIO.write(tempShare, "png", tempOutput);
                    } catch (IOException e) {
                        System.out.println("Error!");
                    }
                }
            }
        }
    }
}
