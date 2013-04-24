package br.org.groupwareworkbench.arquigrafia.imports;

import org.junit.Test;

import br.org.groupwareworkbench.arquigrafia.InvalidCellContents;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowCommercialUses;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowModifications;
import static org.junit.Assert.*;

public class LicenseMapperTest {

    @Test
    public void test() {
        
        LicenseMapper licenseMapper = new LicenseMapper();
        assertTrue( licenseMapper.checkValidLicense("NO-NO") );
        assertFalse( licenseMapper.checkValidLicense("N") );
        assertFalse( licenseMapper.checkValidLicense("") );
        assertFalse( licenseMapper.checkValidLicense("NN") );
        
        try {
            assertSame( AllowCommercialUses.NO , licenseMapper.getAllowCommercialUses("NO-NO") );
            assertSame( AllowCommercialUses.YES , licenseMapper.getAllowCommercialUses("YES-NO") );
            assertSame( AllowModifications.NO , licenseMapper.getAllowModifications("NO-NO") );
            assertSame( AllowModifications.YES , licenseMapper.getAllowModifications("NO-YES") );
            assertSame( AllowModifications.YES_SA , licenseMapper.getAllowModifications("NO-YES_SA") );
            
        } catch (InvalidCellContents e) {
            fail();
        }
        
    }
    
}
