package br.org.groupwareworkbench.arquigrafia.indexer;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaController;
import br.org.groupwareworkbench.arquigrafia.main.ArquigrafiaMgrInstance;

@Resource
public class IndexerController {
    
    private final Result result;
    private final Indexer indexer;
    
    public IndexerController(Result result, Indexer indexer) {
        this.result = result;
        this.indexer = indexer;
    }

    @Get
    @Path("/{arquigrafiaInstance}/indexer")
    public void create(ArquigrafiaMgrInstance arquigrafiaInstance) {
        
        indexer.create();

        result.redirectTo(ArquigrafiaController.class).index(arquigrafiaInstance);
    }
    
    
    
}
