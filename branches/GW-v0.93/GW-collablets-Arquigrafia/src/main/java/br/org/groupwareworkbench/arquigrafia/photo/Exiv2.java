package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

import br.org.groupwareworkbench.arquigrafia.license.CreativeCommons_3_0;

/**
 * Wrapper for the exiv2 utility which changes image metadata. This class performs all operations
 * on the set of images and assumes that all images have the ".jpg" extension.
 * 
 * @author AAMM
 */
public class Exiv2 {
    
    public static void main(final String[] args) {
        
        if(args.length!=9) {
            System.out.println("Usage: originalFileExtension id imagesDir allowCommercialUses allowModifications author user description userComment");
            System.out.println();
            System.out.println("Example: JPEG 999 /home/user/myImages YES YES_SA \"Ordinary Joe\" \"joe\" \"My description\" \"User comment\"");
            System.exit(1);
        }
        
        String originalFileExtension = args[0];
        Long id = new Long(args[1]);
        String imagesDir = args[2];
        CreativeCommons_3_0 license = new CreativeCommons_3_0(Photo.AllowCommercialUses.valueOf(args[3]), Photo.AllowModifications.valueOf(args[4]));
        String author = args[5];
        String user = args[6];
        String description = args[7];
        String userComment = args[8];
        
        Exiv2 imw = new Exiv2(originalFileExtension, id, imagesDir);
        imw.setCopyRight(author, license);
        imw.setAuthor(author);
        imw.setArtist(author, user);
        imw.setDescription(description);
        imw.setUserComment(userComment);
        System.exit(0);
    }
    
    private String originalFileExtension;
    private long imageId;
    private String imagesDirName;
    
    public Exiv2(final String originalFileExtension, final long imageId, final String imagesDirName) {
        this.originalFileExtension = originalFileExtension;
        this.imageId = imageId;
        this.imagesDirName = imagesDirName;
    }
    
    public void setAuthor(final String author) {
        runExif2("Exif.Image.XPAuthor %s", toXP(author));
    }
    
    public void setArtist(final String artist, final String user) {
        runExif2("Exif.Image.Artist %s - %s", artist, user);
    }
    
    public void setCopyRight(final String author, final CreativeCommons_3_0 ccl) {
        runExif2("Exif.Image.Copyright %s - %s - %s", author, ccl.getLongLicenseName(), ccl.getURIString());
        runExif2("Iptc.Application2.Copyright %s - %s - %s", author, ccl.getLongLicenseName(), ccl.getURIString());
    }
    
    public void setDescription(final String description) {
        runExif2("Exif.Image.ImageDescription %s", description);
    }
    
    public void setUserComment(final String userComment) {
        runExif2("Exif.Photo.UserComment %s", userComment);
    }
    
    private void runExif2(final String command, final Object... args) {
        
        runExif2_internal(Photo.ORIGINAL_FILE_SUFFIX, originalFileExtension, command, args);
        
        for (String sufix: Photo.ADDITIONAL_FILE_SUFIXES) {
            runExif2_internal(sufix, Photo.DEFAULT_EXTENSION, command, args);
        }
    }
    
    private void runExif2_internal(final String sufix, final String extension, final String command, final Object... args) {
        try {
            String exivCommand = String.format("set " + command, args);
            String fileName = String.format("%s%s.%s", imageId, sufix, extension);
            String[] cmdArray = new String[]{"exiv2", "-M", exivCommand, fileName};
            Process p = Runtime.getRuntime().exec(cmdArray, null, new File(imagesDirName));
            p.waitFor();
            int exitValue = p.exitValue();
            if (exitValue != 0) {
                System.out.println("Problem running exiv2. Exit value: " + exitValue);
                System.out.println("This is the command we've tried to execute: " + Arrays.toString(cmdArray));
                System.out.println("This is the base dir: " + imagesDirName);
                System.out.println("-------------------------");
                InputStream os = p.getInputStream();
                byte[] buffer = new byte[os.available()];
                os.read(buffer);
                System.out.println("-------------------------");
                System.out.println(new String(buffer));
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Converts a string to its XP representation format, which is used in some of the tags that
     * start with "Exif.Image.XP".
     * 
     * @param string
     * @return
     */
    private String toXP(final String string) {
        byte[] bytes = string.getBytes();
        String result = "";
        for(byte b : bytes) {
            int x = b;
            result += String.format("%d 0 ", x);
        }
        result += "0 0";
        return result;
    }
}
