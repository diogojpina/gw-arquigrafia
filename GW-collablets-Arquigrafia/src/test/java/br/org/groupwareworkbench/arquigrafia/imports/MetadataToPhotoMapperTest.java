package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileNotFoundException;

import org.junit.Test;

import sun.org.mozilla.javascript.ImporterTopLevel;
import static org.junit.Assert.*;

public class MetadataToPhotoMapperTest {

    @Test
    public void testLogFile() {

        String sourceFile = "myFile.ods";

        ImportLogger logger = new ImportLogger(new File("./" + sourceFile));
        MetaDataToPhotoMapper dataToPhotoMapper = new MetaDataToPhotoMapper(logger);
        assertEquals(String.format("%s.log", sourceFile), logger.getFileLog().getName());

    }

}
