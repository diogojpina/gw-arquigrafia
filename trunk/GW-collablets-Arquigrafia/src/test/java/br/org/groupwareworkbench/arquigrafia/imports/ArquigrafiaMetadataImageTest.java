package br.org.groupwareworkbench.arquigrafia.imports;

import org.junit.Test;
import static org.junit.Assert.*;

public class ArquigrafiaMetadataImageTest {

    private final static String resourcePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/";

    @Test
    public void test() {
        
        String[] arrayValues = new String[ArquigrafiaImageMetadataOdsIndexes.values().length];
        arrayValues[ArquigrafiaImageMetadataOdsIndexes.TOMBO.getColumnIndex()] = "image1";
        ArquigrafiaImageMetadata photoMetadata = ArquigrafiaImageMetadata.fromRow(resourcePath, arrayValues);
        assertNotNull(photoMetadata.getImageFile());
        assertTrue("image1.jpg".equals(photoMetadata.getImageFile().getName()));
        assertTrue(photoMetadata.getImageFile().exists());
        
    }
    

    
    
    
}
