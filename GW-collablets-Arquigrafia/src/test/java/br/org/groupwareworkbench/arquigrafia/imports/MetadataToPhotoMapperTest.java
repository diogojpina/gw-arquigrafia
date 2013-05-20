package br.org.groupwareworkbench.arquigrafia.imports;

import static org.junit.Assert.assertEquals;

import java.io.File;

import org.junit.Test;

public class MetadataToPhotoMapperTest {

    @Test
    public void testLogFile() {

        String sourceFile = "myFile.ods";

        ImportLogger logger = new ImportLogger(new File("./" + sourceFile));
        MetaDataToPhotoMapper dataToPhotoMapper = new MetaDataToPhotoMapper(logger);
        assertEquals(String.format("%s.log", sourceFile), logger.getFileLog().getName());

    }

}
