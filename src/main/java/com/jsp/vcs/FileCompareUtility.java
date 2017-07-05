package com.jsp.vcs;

/**
 * Created by LonelyTomb on 7/3/2017.
 */


public class FileCompareUtility {
    MD5EncoderUtility md5EncoderUtil = new MD5EncoderUtility();

    public boolean compare2Files(String actualFilePath, String expectedFilePath) {
        if ((md5EncoderUtil.encodeToMd5(actualFilePath)).equals(md5EncoderUtil.encodeToMd5(expectedFilePath))) {
            System.out.println("The files- " + actualFilePath + " and " + expectedFilePath + " are same");
            return true;
        } else {
            System.out.println("The files- " + actualFilePath + " and " + expectedFilePath + " are NOT same");
            return false;
        }
    }

}