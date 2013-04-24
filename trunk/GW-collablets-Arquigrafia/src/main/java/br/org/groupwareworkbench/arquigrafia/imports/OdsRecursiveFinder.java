package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.util.HashSet;
import java.util.Set;

public class OdsRecursiveFinder {

    Set<File> results;

    public OdsRecursiveFinder() {
        this.results = new HashSet<File>();
    }

    public void find(File dir) {
        for (File file : dir.listFiles()) {
            if (file.isFile() && file.getName().endsWith(".ods")) {
                results.add(file);
            }
            if (file.isDirectory()) {
                find(file);
            }
        }
    }

    public Set<File> getResults() {
        return results;
    }

}
