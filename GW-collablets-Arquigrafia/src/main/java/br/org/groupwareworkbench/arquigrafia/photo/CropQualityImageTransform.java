package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;

import br.org.groupwareworkbench.core.graphics.BatchImageProcessor;
import br.org.groupwareworkbench.core.graphics.GWImage;
import br.org.groupwareworkbench.core.graphics.ImageTransformation;
import br.org.groupwareworkbench.core.util.debug.TimeLog;

/**
 * Stand alone application that automatically browses a certain directory searching for high quality images to generate.
 * Images that already have a high quality version are identified by the presence of an empty file. Here is the file
 * name convention:<br>
 * <ol>
 * <li>A_original.XYZ - The original image. XYZ is any image format.</li>
 * <li>A_view.jpg - The view version of the image in the JPG format.</li>
 * <li>A_panel.jpg - The panel version of the image in the JPG format.</li>
 * <li>A_thumb.jpg - The thumb version of the image in the JPG format.</li>
 * <li>A_ok - The marker file. If this file exists, this procedure will skip the generation of images for this original
 * image.</li>
 * </ol>
 * 
 * @author gw
 */
public class CropQualityImageTransform {

    /**
     * @param args
     */
    public static void main(String[] args) {
        if (args.length != 4) {
            System.err.println("ERROR: Please inform the quality, width, height and the directory to check");
            System.exit(1);
            return;
        }
        new CropQualityImageTransform().convert(args[0], Integer.parseInt(args[1]), Integer.parseInt(args[2]), args[3]);
        // new CropQualityImageTransform().convert("100", 170, 117,
        // "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/tests");
    }

    public void convert(String quality, final int width, final int height, String dirName) {

        File dir = new File(dirName);
        if (!dir.exists()) {
            System.err.println("ERROR: " + dirName + " does not exist.");
            System.exit(2);
            return;
        }
        if (!dir.isDirectory()) {
            System.err.println("ERROR: " + dirName + " is not a directory.");
            System.exit(3);
            return;
        }

        File[] files = dir.listFiles(new FilenameFilter() {

            @Override
            public boolean accept(File dir, String name) {
                if (name.contains("_original.")) return true;
                return false;
            }
        });

        Runtime r = Runtime.getRuntime();

        // Checking if the command gm is available in the operating system.
        boolean gmAvailable = false;
        try {
            r.exec("gm").waitFor();
            gmAvailable = true;
        } catch (IOException e) {
            System.out.println("Failed running gm. Will continue without it.");
        } catch (InterruptedException e) {
        }

        for (File file : files) {

            String id = file.getName().substring(0, file.getName().indexOf('_'));
            File marker = new File(dir.getAbsolutePath() + File.separator + id + "_crop");

            if (!marker.exists()) {
                System.out.println(file.getAbsolutePath());
                System.out.println("id = " + id);

                try {

                    TimeLog tl = new TimeLog("GM");

                    String cropName = dir.getAbsolutePath() + File.separator + id + "_crop.jpg";

                    if (gmAvailable) {
                        // Getting original image dimensions
                        Process p = r.exec(new String[] {"gm", "identify", file.getAbsolutePath()});
                        p.waitFor();
                        InputStream is = p.getInputStream();
                        byte[] buff = new byte[is.available()];
                        is.read(buff);
                        String output = new String(buff);
                        output = output.substring(output.indexOf(' ') + 1);
                        output = output.substring(output.indexOf(' ') + 1);
                        int originalWidth = Integer.parseInt(output.substring(0, output.indexOf('x')));
                        int originalHeight =
                                Integer.parseInt(output.substring(output.indexOf('x') + 1, output.indexOf('+')));

                        tl.log("Retrieving properties of " + file.getAbsolutePath());

                        {
                            double xScale = ((double) width) / ((double) originalWidth);
                            double yScale = ((double) height) / ((double) originalHeight);
                            double factor = Math.max(xScale, yScale);
                            int newWidth = (int) (originalWidth * factor);
                            int newHeight = (int) (originalHeight * factor);

                            r.exec(new String[] {"gm", "mogrify", "-geometry", newWidth + "x" + newHeight, "-quality",
                                    quality, cropName}).waitFor();

                            int x = xScale > yScale ? 0 : (int) ((originalWidth * factor) / 2 - width / 2);
                            int y = xScale > yScale ? (int) ((originalHeight * factor) / 2 - height / 2) : 0;

                            r.exec(new String[] {"gm", "mogrify", "-crop", width + "x" + height + "+" + x + "+" + y,
                                    cropName}).waitFor();
                        }

                        tl.log("Creation of " + cropName);

                        tl.total();

                    } else {

                        BatchImageProcessor bip = new BatchImageProcessor(file, dir);

                        bip.addImageTransformation(new ImageTransformation() {
                            @Override
                            public String name() {
                                return "crop";
                            }

                            @Override
                            public GWImage transform(GWImage image) throws IOException {
                                return image.doTheBestYouCanToFitOnRectangle(width, height);
                            }
                        });

                        bip.runBatch();

                    }
                    marker.createNewFile();

                } catch (Throwable t) {
                    t.printStackTrace();
                }
            }
        }
        System.out.println("The End!");
    }

}
