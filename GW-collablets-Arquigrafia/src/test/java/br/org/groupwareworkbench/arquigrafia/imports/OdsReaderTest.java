package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.util.Collection;

import org.junit.Test;
import static org.junit.Assert.*;

public class OdsReaderTest {

    private static final String smallResourceFilePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/small.ods";
    private static final String largeResourceFilePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/large.ods";
    private static final String manySheetsResourceFilePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/largeManySheets.ods";
    
    @Test
    public void test() {
        
        testForFile(smallResourceFilePath);
        testForFile(largeResourceFilePath);
        testForFile(manySheetsResourceFilePath);
        
    }

    private void testForFile(String filePath) {
        ArquigrafiaOdsReader imagesMetadataReader = setupArquigrafiaOdsFileReader(filePath);
        Collection<ArquigrafiaImageMetadata> metadataImages = imagesMetadataReader.read();
        assertTrue(!metadataImages.isEmpty() );
        for ( ArquigrafiaImageMetadata selectedmetadata : metadataImages ) {
            assertFalse(selectedmetadata.toString().isEmpty() );
        }
        System.out.println(String.format("Ods File %s has %d entries.", filePath ,metadataImages.size()));
    }

    private ArquigrafiaOdsReader setupArquigrafiaOdsFileReader(String filePath) {
        File odsTestResourceFile = new File(filePath);
        assertTrue( odsTestResourceFile.exists() );
        ArquigrafiaOdsReader imagesMetadataReader = new ArquigrafiaOdsReader(odsTestResourceFile);
        return imagesMetadataReader;
    }
    
}
