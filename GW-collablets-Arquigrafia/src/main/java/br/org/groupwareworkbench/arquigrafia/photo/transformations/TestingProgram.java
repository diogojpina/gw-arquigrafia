package br.org.groupwareworkbench.arquigrafia.photo.transformations;

import java.io.File;
import java.io.IOException;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.core.graphics.BatchImageProcessor;

public class TestingProgram {

    /**
     * @param args
     * @throws IOException 
     */
    public static void main(String[] args) throws IOException {
        BatchImageProcessor bip = new BatchImageProcessor(new File("/home/gw/workspace/Z-JPEG_Metadata_Manipulation/images/another_tall_original.jpg"), new File("/home/gw/workspace/Z-JPEG_Metadata_Manipulation/dest/"), Photo.ORIGINAL_FILE_SUFFIX);
        bip.addImageTransformation(new Thumb());
        bip.addImageTransformation(new Panel());
        bip.addImageTransformation(new View());
        bip.runBatch();
    }

}
