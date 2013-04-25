package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.HashSet;
import java.util.Set;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;

@Component
@ApplicationScoped
public final class search {
    
    
    private Set<String> names;
    
    public search() {
        names = new HashSet<String>();
        names.add("name");
        names.add("city");
        names.add("district");
        names.add("street");
        names.add("imageAuthor");
        names.add("workAuthor");
    }
    
    public boolean contains(String term) {
        return names.contains(term);
    }

    public Set<String> getNames() {
        return names;
    }
    
}
