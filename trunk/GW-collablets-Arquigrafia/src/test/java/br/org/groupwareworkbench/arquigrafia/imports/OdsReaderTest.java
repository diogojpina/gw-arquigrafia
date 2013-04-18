package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.util.Collection;

import org.junit.Test;
import static org.junit.Assert.*;

public class OdsReaderTest {

    private static final String resourceFilePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/planilha.ods";
    
    @Test
    public void test() {
        
        File odsTestResourceFile = new File(resourceFilePath);
        assertTrue( odsTestResourceFile.exists() );
        ArquigrafiaOdsReader imagesMetadataReader = new ArquigrafiaOdsReader(odsTestResourceFile);
        assertTrue(imagesMetadataReader.getSheetCount() == 1 );
        Collection<ArquigrafiaImageMetadata> metadataImages = imagesMetadataReader.read();
        System.out.println(metadataImages.size());
        assertTrue(metadataImages.size() == 3 );
        
    }
    
}
