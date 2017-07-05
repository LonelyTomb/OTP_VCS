/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.jsp.vcs;

//import javax.media.jai.Histogram;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.File;
import javax.imageio.ImageIO;

/**
 *
 * @author S
 */
public class PerformanceFactor {

    public static double pixelExpansion(int init_width_size,int fin_width_size,int init_height_size,int fin_height_size)
    {
        double expanded_value=0;
        expanded_value=(init_height_size*init_width_size)/(fin_height_size*fin_width_size);
        return expanded_value;
    }
 /*   public void kgreyThresh(double k) {
Histogram rh = new Histogram(r,"red");
double cmf[] = rh.getCMF();
TransformTable tt = new TransformTable(cmf.length);
short lut[] = tt.getLut();
int q=1;
short v=0;
short dv = ( short)(255/k);
for ( int i=0; i < lut.length; i++) {
if (cmf[i] > q/k) {
v += dv;
q++; //(k == q+1)||
if (q==k) v=255;
}
lut[i]=v;
}
tt.setLut(lut);
tt.clip();
tt.print();
applyLut(lut);
}*/
    public static void PSNR()
    {
        BufferedImage original=loadImage("C:/Users/S/Documents/NetBeansProjects/seminar/apple.jpg");
        BufferedImage decrypted=loadImage("C:/Users/S/Documents/NetBeansProjects/seminar/share31.jpg");
        int height=original.getHeight();
        int width=original.getWidth();
        int sum=0;
        int[][] orig_dec=ImagetoBinarypixels(original);
     printArray(orig_dec);
        for(int i=0;i<width;i++)
        {
                for(int j=0;j<height;j++)
            {

            }
        }

    }
    public static int[][] ImagetoBinarypixels(BufferedImage img) {
       Raster img_raster = img.getData();
        int original[][];
        int[] pixel = new int[8];
        int[] buffer = new int[8];
        int[] len = new int[8];


        original = new int[img_raster.getWidth()][img_raster.getHeight()];

        for (int i = 0; i < img_raster.getWidth(); i++) {
            for (int j = 0; j < img_raster.getHeight(); j++) {
                pixel = img_raster.getPixel(i, j, buffer);
                original[i][j] = pixel[0];
            }

        }
        return original;
    }
    static BufferedImage loadImage(String filename) {
        BufferedImage in;
        try {
            File filein = new File(filename);
            in = ImageIO.read(filein);
        } catch (Exception ex) {
            in = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB);
        }
        return in;
    }
    public static void printArray(int[][] binary) {
        for (int i = 0; i < binary.length; i++) {
            for (int j = 0; j < binary[i].length; j++) {
                System.out.print(" " + binary[i][j]);
            }
            System.out.println("\n");
        }
    }


}
