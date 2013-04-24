package br.org.groupwareworkbench.arquigrafia.imports;

import static org.junit.Assert.assertTrue;

import java.io.File;

import org.junit.Test;

public class OdsRecursiveFinderTest {

    @Test
    public void test() {

        File baseDir = new File("/home/gw/imports/");
        System.out.println(baseDir.getAbsolutePath());
        OdsRecursiveFinder ods = new OdsRecursiveFinder();
        ods.find(baseDir);
        System.out.println(ods.getResults().size());
        assertTrue( !ods.getResults().isEmpty() );
        
    }
    
}
