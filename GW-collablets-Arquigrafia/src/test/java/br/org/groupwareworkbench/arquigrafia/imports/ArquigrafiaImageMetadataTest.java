package br.org.groupwareworkbench.arquigrafia.imports;

import java.lang.reflect.Field;
import java.util.Arrays;

import org.junit.Test;
import static org.junit.Assert.*;

public class ArquigrafiaImageMetadataTest {

    @Test
    public void test() {

        String[] arrayValues = new String[ArquigrafiaImageMetadataOdsIndexes.values().length];
        for (ArquigrafiaImageMetadataOdsIndexes index : ArquigrafiaImageMetadataOdsIndexes.values()) {
            arrayValues[index.getColumnIndex()] = index.getTitle();
        }
        ArquigrafiaImageMetadata created = ArquigrafiaImageMetadata.fromRow(arrayValues);
        try {
            for (ArquigrafiaImageMetadataOdsIndexes index : ArquigrafiaImageMetadataOdsIndexes.values()) {

                Field fieldFromIndex = ArquigrafiaImageMetadata.class.getDeclaredField(index.name());
                assertSame( fieldFromIndex.get( created ),  index.getTitle() );
                
            }
        } catch (Exception exception) {
            exception.printStackTrace();
            fail();
        }

    }

}
