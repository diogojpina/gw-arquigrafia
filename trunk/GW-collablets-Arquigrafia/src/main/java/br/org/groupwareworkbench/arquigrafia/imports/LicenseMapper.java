package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;

import br.org.groupwareworkbench.arquigrafia.InvalidCellContents;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowCommercialUses;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowModifications;

//TODO tests
public class LicenseMapper {

    public LicenseMapper() {
    }
    
    public boolean checkValidLicense(String license) {
        if ( license.isEmpty() || !license.contains("-") ) {
            return false;
        }
        return true;
    }
    
    public AllowCommercialUses getAllowCommercialUses(String license) throws InvalidCellContents {
        if ( checkValidLicense(license) ) {
            return AllowCommercialUses
                    .valueOf(license.substring(0, license.indexOf('-')).toUpperCase().trim());
        }
        throw new InvalidCellContents(String.format("Invalid license :%s", license));
    }
    
    public AllowModifications getAllowModifications(String license) throws InvalidCellContents {
        if ( checkValidLicense(license) ) {
            return AllowModifications.valueOf(license.substring(license.indexOf('-') + 1, license.length())
                    .toUpperCase().trim());
        }
        throw new InvalidCellContents(String.format("Invalid license :%s", license));
    }
    
}