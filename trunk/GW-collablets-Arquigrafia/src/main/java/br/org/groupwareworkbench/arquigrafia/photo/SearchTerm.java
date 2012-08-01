package br.org.groupwareworkbench.arquigrafia.photo;

import com.google.common.collect.ImmutableSet;

public final class SearchTerm {
    
    private static ImmutableSet<String> names = ImmutableSet.of("name", "city");
    
    public static boolean contains(String term) {
        return names.contains(term);
    }

    public static ImmutableSet<String> getNames() {
        return names;
    }
    
}
