package br.org.groupwareworkbench.arquigrafia.indexer;

import javax.persistence.EntityManager;

import org.hibernate.search.jpa.FullTextEntityManager;

import br.com.caelum.vraptor.ioc.Component;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;

@Component
public class Indexer {
    
    
    public void create() {
        EntityManager em = EntityManagerProvider.getEntityManager();
        FullTextEntityManager fullTextEntityManager = org.hibernate.search.jpa.Search.getFullTextEntityManager(em);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    
}
