package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileNotFoundException;

import org.junit.Test;
import static org.junit.Assert.*;

public class MetadataToPhotoMapperTest {

    
    @Test
    public void testLogFile() {
        
        String sourceFile = "myFile.ods";
        try {
            MetaDataToPhotoMapper dataToPhotoMapper = new MetaDataToPhotoMapper(new File("./"+sourceFile));
            assertEquals( String.format("%s.log", sourceFile ), dataToPhotoMapper.getFileLog().getName() );
        } catch (FileNotFoundException e) {
            fail();
        }
        
    }
    
}
