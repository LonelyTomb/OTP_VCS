package com.jsp.vcs;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

import javax.imageio.*;

public class MastersProjAppTextVersion {

    public static void createimage(String text,String filename) {
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
            ImageIO.write(img, "jpeg", new File(filename+".jpeg"));
        } catch (IOException ex) {
            ex.printStackTrace();
        }


    }

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        int userChoice;
        do {
            System.out.println("Please select which operation you wish to perform by entering the number associated with it.");
            System.out.println("\t1.  Encrypt a photo for secure sharing");
            System.out.println("\t2.  Decrypt a photo given shares");
            System.out.println("\t3.  Terminate the program");
            System.out.print("\nYour choice:  ");
            userChoice = Integer.parseInt(input.nextLine());

            switch (userChoice) {
                case 1:
                    System.out.println("\nThis assumes you only want two shares for encryption.");

                    String secretFile;
                    String[] innocentFiles = new String[2];
                    //get name of secret msg file
                    System.out.print("Enter the name of your secret image file:  ");
                    secretFile = input.nextLine();

                    BufferedImage secretImage = null;
                    boolean fileFound;
                    File ts = new File(secretFile);

                    try {
                       createimage("12345","Text");
                        secretImage = ImageIO.read(new File("Text.jpeg"));

                        fileFound = true;
                    } catch (IOException e) {
                        System.out.println("Error:  The file you tried to encrypt does not exist." + e.getMessage());
                        System.out.println(ts.getAbsolutePath());
                        fileFound = false;
                    }

                    if (fileFound) {
                        //get name of innocent 1
                        //get name of innocent 2
                        for (int i = 0; i < 2; i++) {
                            createimage("","sh-0"+i);
                            System.out.print("Please enter the name of one of the \"innocent\" file shares:  ");
                            innocentFiles[i] = input.nextLine();
                        }
                        BufferedImage[] innocentShares = new BufferedImage[2];
                        for (int i = 0; i < 2; i++) {
                            try {
                                innocentShares[i] = ImageIO.read(new File(innocentFiles[i]));
                                fileFound = true;
                            } catch (IOException e) {
                                String errorString = "Error:  The file \"" + innocentFiles[i] + "\" does not exist.";
                                System.out.print(errorString);
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
                            System.out.print("Do you wish to store these shared file in a subdirectory of this folder?  Yes or No:  ");
                            String folderResponse = input.nextLine();
                            boolean storeInFolder = (folderResponse.trim().charAt(0) == 'y' || folderResponse.trim().charAt(0) == 'Y');
                            String folderName = "";
                            if (storeInFolder) {
                                System.out.print("Please enter the name of the folder without a trailing slash:  ");
                                folderName = input.nextLine();
                                File directory = new File(folderName);
                                directory.mkdir();
                            }
                            String[] shareFiles = new String[2];
                            for (int i = 0; i < 2; i++) {
                                if (storeInFolder) {
                                    shareFiles[i] = folderName + "/share" + (i + 1) + ".png";
                                } else {
                                    shareFiles[i] = "share" + (i + 1) + ".png";
                                }
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
                        System.out.println("\n");
                    }
                    break;

                case 2:
                    System.out.println("\nThis assumes you only have two shares for decryption.");

                    //Get filenames of those shares
                    String[] shareFiles = new String[2];
                    for (int i = 0; i < 2; i++) {
                        System.out.print("Please enter the filename for one of your shares:  ");
                        shareFiles[i] = input.nextLine();
                    }

                    //Convert images to BufferedImage objects
                    BufferedImage[] sharesEVCS = new BufferedImage[2];
                    boolean foundFilesEVCS = false;
                    for (int i = 0; i < 2; i++) {
                        try {
                            //Supports GIF, PNG, JPEG, BMP, and WBMP
                            //Plug-ins for TIFF and JPEG 2000
                            sharesEVCS[i] = ImageIO.read(new File(shareFiles[i]));
                            foundFilesEVCS = true;
                        } catch (IOException e) {
                            String errorString = "Error:  The file \"" + shareFiles[i] + "\" does not exist, so it cannot be superimposed.";
                            System.out.print(errorString);
                            foundFilesEVCS = false;
                        }
                    }

                    if (foundFilesEVCS) {
                        ExtendedVCS myEVCS = new ExtendedVCS(sharesEVCS);
                        myEVCS.decryptImage();

                        //Write the new image
                        System.out.print("Please enter the file name you wish to give your stacked image:  ");
                        String decryptedFileName = input.nextLine();
                        int fileExtension = decryptedFileName.indexOf('.');
                        String extensionEVCS = decryptedFileName.substring(fileExtension + 1);
                        try {
                            //Takes the pixel array and creates a new buffered image
                            BufferedImage decryptedImage = new BufferedImage(myEVCS.getImgWidth(), myEVCS.getImgHeight(),
                                    BufferedImage.TYPE_INT_ARGB);
                            decryptedImage.setRGB(0, 0, myEVCS.getImgWidth(), myEVCS.getImgHeight(),
                                    myEVCS.getDecryptImgPixels(), 0, myEVCS.getImgWidth());

                            //Creates the file name of the new image
                            File tempOutput = new File(decryptedFileName);

                            //Writes the buffered image to a png file
                            ImageIO.write(decryptedImage, extensionEVCS, tempOutput);
                        } catch (IOException e) {
                            System.out.println("Error!");
                        }

                    }
                    System.out.println("\n");

                    break;

                case 3:
                    System.out.println("Terminating program...");
            }
        } while (userChoice != 3);

    }
}