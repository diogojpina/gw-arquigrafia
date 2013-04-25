package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.HashSet;
import java.util.Set;

public final class SearchTerm {
    
    private static Set<String> names = new HashSet<String>();
//    "name", "city", "district", "street", "workAuthor"
    static {
        names.add("name");
        names.add("city");
        names.add("district");
        names.add("street");
        names.add("workAuthor");
        names.add("imageAuthor");
    }
    
    public static boolean contains(String term) {
        return names.contains(term);
    }

    public static Set<String> getNames() {
        return names;
    }
    
}
