package br.org.groupwareworkbench.arquigrafia.license;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;

public class CreativeCommons_3_0 {
    
    private Photo.AllowCommercialUses allowCommercialUses;
    private Photo.AllowModifications allowModifications;
    
    public CreativeCommons_3_0(Photo.AllowCommercialUses allowCommercialUses, Photo.AllowModifications allowModifications) {
        this.allowCommercialUses = allowCommercialUses;
        this.allowModifications = allowModifications;
    }
    
    public Photo.AllowModifications getAllowModifications() {
        return allowModifications;
    }
    
    public Photo.AllowCommercialUses getAllowCommercialUses() {
        return allowCommercialUses;
    }
    
    public String getLongLicenseName() {
        return "Creative Commons 3.0 " + getShortLicenseName();
    }
    
    public String getShortLicenseName() {
        String result = "BY";
        switch (allowCommercialUses) {
            case YES:
                // Nothing
                break;
            case NO:
                result += "-NC";
                break;
        }
        switch (allowModifications) {
            case YES:
                // Nothing
                break;
            case YES_SA:
                result += "-SA";
                break;
            case NO:
                result += "-ND";
                break;
        }
        return result;
    }
    
    public String getURIString() {
        return String.format("http://creativecommons.org/licenses/%s/3.0/deed.pt_BR", getShortLicenseName().toLowerCase());
    }

    @Override
    public String toString() {
        return getShortLicenseName();
    }
}
