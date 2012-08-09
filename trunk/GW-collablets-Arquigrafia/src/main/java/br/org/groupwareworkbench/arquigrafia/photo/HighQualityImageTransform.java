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
public class HighQualityImageTransform {

    /**
     * @param args
     */
    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("ERROR: Please inform the quality and the directory to check");
            System.exit(1);
            return;
        }
        new HighQualityImageTransform().convert(args[0], args[1]);
    }

    public void convert(String quality, String dirName) {

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
            File marker = new File(dir.getAbsolutePath() + File.separator + id + "_ok");

            if (!marker.exists()) {
                System.out.println(file.getAbsolutePath());
                System.out.println("id = " + id);

                try {

                    TimeLog tl = new TimeLog("GM");

                    String viewName = dir.getAbsolutePath() + File.separator + id + "_view.jpg";
                    String panelName = dir.getAbsolutePath() + File.separator + id + "_panel.jpg";
                    String thumbName = dir.getAbsolutePath() + File.separator + id + "_thumb.jpg";

                    if (gmAvailable) {
                        tl.log("Convertion to JPG");
                        Process p = r.exec(new String[] {"gm", "convert", file.getAbsolutePath(), "jpg:" + viewName});
                        p.waitFor();
                        if (p.exitValue() != 0) {
                            System.err.println("Problems!");
                        }
                        // Getting original image dimensions
                        p = r.exec(new String[] {"gm", "identify", file.getAbsolutePath()});
                        p.waitFor();
                        InputStream is = p.getInputStream();
                        byte[] buff = new byte[is.available()];
                        is.read(buff);
                        String output = new String(buff);
                        output = output.substring(output.indexOf(' ') + 1);
                        output = output.substring(output.indexOf(' ') + 1);
                        int width = Integer.parseInt(output.substring(0, output.indexOf('x')));
                        int height = Integer.parseInt(output.substring(output.indexOf('x') + 1, output.indexOf('+')));

                        tl.log("Retrieving properties of " + file.getAbsolutePath());

                        {
                            double scale = ((double) 600) / ((double) width);
                            width = 600;
                            height = (int) Math.ceil(height * scale);

                            r.exec(new String[] {"gm", "mogrify", "-geometry", "600x" + height, "-quality", quality, viewName}).waitFor();
                        }

                        tl.log("Creation of " + viewName);

                        BatchImageProcessor.copyFile(file.getAbsolutePath(), panelName);

                        {
                            double xScale = ((double) 170) / ((double) width);
                            double yScale = ((double) 117) / ((double) height);
                            double factor = Math.max(xScale, yScale);
                            int newWidth = (int) (width * factor);
                            int newHeight = (int) (height * factor);

                            r.exec(new String[] {"gm", "mogrify", "-geometry", newWidth + "x" + newHeight, "-quality", quality, panelName}).waitFor();

                            int x = xScale > yScale ? 0 : (int) ((width * factor) / 2 - 170 / 2);
                            int y = xScale > yScale ? (int) ((height * factor) / 2 - 117 / 2) : 0;

                            r.exec(new String[] {"gm", "mogrify", "-crop", "170x117+" + x + "+" + y, panelName}).waitFor();
                        }

                        tl.log("Creation of " + panelName);

                        BatchImageProcessor.copyFile(file.getAbsolutePath(), thumbName);

                        {
                            double xScale = ((double) 105) / ((double) width);
                            double yScale = ((double) 72) / ((double) height);
                            double factor = Math.max(xScale, yScale);
                            int newWidth = (int) (width * factor);
                            int newHeight = (int) (height * factor);

                            r.exec(new String[] {"gm", "mogrify", "-geometry", newWidth + "x" + newHeight, "-quality", quality, thumbName}).waitFor();

                            int x = xScale > yScale ? 0 : (int) ((width * factor) / 2 - 105 / 2);
                            int y = xScale > yScale ? (int) ((height * factor) / 2 - 72 / 2) : 0;

                            r.exec(new String[] {"gm", "mogrify", "-crop", "105x72+" + x + "+" + y, thumbName}).waitFor();
                        }

                        tl.log("Creation of " + thumbName);
                        tl.total();

                        /* 
                         * Unfortunately, gm does not copy the metadata to new files. So we need to
                         * do it manually.
                         */
                        new Exiv2(file.getAbsolutePath()).copyMetadataFromOriginal();
                        
                        marker.createNewFile();

                    } else {

                        BatchImageProcessor bip = new BatchImageProcessor(file, dir);

                        bip.addImageTransformation(new ImageTransformation() {
                            @Override
                            public GWImage transform(GWImage image) throws IOException {
                                return image.doTheBestYouCanToFitOnRectangle(105, 72);
                            }

                            @Override
                            public String name() {
                                return "thumb";
                            }
                        });

                        bip.addImageTransformation(new ImageTransformation() {
                            @Override
                            public String name() {
                                return "panel";
                            }

                            @Override
                            public GWImage transform(GWImage image) throws IOException {
                                return image.doTheBestYouCanToFitOnRectangle(170, 117);
                            }
                        });

                        bip.addImageTransformation(new ImageTransformation() {
                            @Override
                            public String name() {
                                return "view";
                            }

                            @Override
                            public GWImage transform(GWImage image) throws IOException {
                                if (image.getWidth() > 600) {
                                    return image.scaleToWidth(600);
                                }
                                return image;
                            }
                        });
                        bip.runBatch();
                    }

                } catch (Throwable t) {
                    t.printStackTrace();
                }
            }
        }
        System.out.println("The End!");
    }

}
