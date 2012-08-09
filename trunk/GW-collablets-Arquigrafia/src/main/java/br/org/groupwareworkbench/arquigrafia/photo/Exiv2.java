package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;

import br.org.groupwareworkbench.arquigrafia.license.CreativeCommons_3_0;
import br.org.groupwareworkbench.core.graphics.BatchImageProcessor;

/**
 * Wrapper for the exiv2 utility which changes image metadata. This class performs all operations
 * on the set of images and assumes that all derivated images (the ones obtained from the original)
 * have the ".jpg" extension.
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
    
    public Exiv2(final String originalFileAbsolutePath) {
        this(originalFileAbsolutePath, true);
    }
    
    public Exiv2(final String originalFileAbsolutePath, final boolean checkFileExists) {
        File originalFile = new File(originalFileAbsolutePath);
        if(checkFileExists && !originalFile.exists()) {
            throw new IllegalArgumentException("File " + originalFileAbsolutePath + " does not exist.");
        }
        this.originalFileExtension = originalFile.getName().substring(originalFile.getName().lastIndexOf('.') + 1, originalFile.getName().length());
        this.imageId = Long.valueOf(originalFile.getName().substring(0, originalFile.getName().indexOf('_')));
        this.imagesDirName = originalFile.getParent();
    }
    
    public String getOriginalFileExtension() {
        return originalFileExtension;
    }

    public long getImageId() {
        return imageId;
    }

    public String getImagesDirName() {
        return imagesDirName;
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
    
    /**
     * Copies all meta data from the original image to the additional images.
     */
    public void copyMetadataFromOriginal() {
        try {
            String originalEXVFileName = String.format("%s/%d%s.exv", imagesDirName, imageId, Photo.ORIGINAL_FILE_SUFFIX);
            String originalImageFileName = String.format("%s/%d%s.%s", imagesDirName, imageId, Photo.ORIGINAL_FILE_SUFFIX, originalFileExtension);
            
            String[] additionalEXVFileNames = new String[Photo.ADDITIONAL_FILE_SUFIXES.length];
            String[] additionalImageFileNames = new String[Photo.ADDITIONAL_FILE_SUFIXES.length];
            
            for(int i=0; i<Photo.ADDITIONAL_FILE_SUFIXES.length; i++) {
                additionalEXVFileNames[i] = String.format("%s/%d%s.exv", imagesDirName, imageId, Photo.ADDITIONAL_FILE_SUFIXES[i]);
                additionalImageFileNames[i] = String.format("%s/%d%s.%s", imagesDirName, imageId, Photo.ADDITIONAL_FILE_SUFIXES[i], Photo.DEFAULT_EXTENSION);
            }
            
            // Let us assume the original file is called /a/b/c/987_original.bmp
            
            // Extracting metadata to file /a/b/c/987_original.exv
            
            String[] command1 = new String[] {"exiv2", "extract", originalImageFileName};
            Runtime.getRuntime().exec(command1).waitFor();
            
            for(int i=0; i<Photo.ADDITIONAL_FILE_SUFIXES.length; i++) {
                // Copying file /a/b/c/987_original.exv to file /a/b/c/987_view.exv etc... 
                BatchImageProcessor.copyFile(originalEXVFileName, additionalEXVFileNames[i]);
                // Inserting metadata to file /a/b/c/987_view.jpg etc...
                String[] command2 = new String[] {"exiv2", "insert", additionalImageFileNames[i]};
                Runtime.getRuntime().exec(command2).waitFor();
                // Cleaning up. Removing exv file
                new File(additionalEXVFileNames[i]).delete();
            }
            
            // Cleaning up. Removing exv file of the original image
            new File(originalEXVFileName).delete();
            
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

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
