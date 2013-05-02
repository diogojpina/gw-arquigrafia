package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class OdsRecursiveFinder {

    Map<String,File> results;

    public OdsRecursiveFinder() {
        this.results = new HashMap<String,File>();
    }

    public void find(File dir) {
        for (File file : dir.listFiles()) {
            if (file.isFile() && file.getName().endsWith(".ods")) {
                results.put(file.getName(),file);
            }
            if (file.isDirectory()) {
                find(file);
            }
        }
    }

    public Collection<File> getResults() {
        return results.values();
    }

}
