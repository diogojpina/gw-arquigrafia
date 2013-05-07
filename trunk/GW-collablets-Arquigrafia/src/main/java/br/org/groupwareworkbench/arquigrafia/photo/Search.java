package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public final class Search {
    
    
    private static Set<String> terms;
    
    static {
        terms = new HashSet<String>() {{
            add("name");
            add("city");
            add("district");
            add("street");
            add("imageAuthor");
            add("workAuthor");
            add("description");
        }};
    }
    
    public static boolean contains(String term) {
        return terms.contains(term);
    }

    public static Set<String> getNames() {
        return Collections.unmodifiableSet(terms);
    }
    
}
