package br.org.groupwareworkbench.arquigrafia.photo;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class Exiv2Test {

    @Test
    public void constructor() {
        Exiv2 e = new Exiv2("/x/y/z/87445434_original.BmP", false);
        assertEquals("BmP", e.getOriginalFileExtension());
        assertEquals(87445434L, e.getImageId());
        assertEquals("/x/y/z", e.getImagesDirName());
    }
}
