package br.org.groupwareworkbench.arquigrafia.site;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupwareworkbench.core.framework.CollabElementInstance;
import br.org.groupwareworkbench.core.framework.CollabletInstance;

@RequestScoped
@Resource
public class SiteController {

    private final Result result;

    public SiteController(Result result) {
        this.result = result;
    }

    @Get
    @Path(value="/groupware-workbench/{siteInstance}/site")
    public void index(SiteInstance siteInstance) {
        addIncludes(siteInstance);
    }

    private void addIncludes(SiteInstance siteInstance) {
        result.include("siteInstance", siteInstance);
        for (CollabElementInstance collabComponentInstance : siteInstance.getCollabElementInstances()) {
            String nomeComponente = collabComponentInstance.getName();
            result.include(nomeComponente, collabComponentInstance);
            System.out.println("O componente elemento " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona os filhos.
        for (CollabletInstance collabletInstance : siteInstance.getSubordinatedInstances()) {
            String nomeComponente = collabletInstance.getComponentInstanceName();
            result.include(nomeComponente, collabletInstance);
            System.out.println("O componente filho" + collabletInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona o antecessores.
        for (CollabletInstance pai : siteInstance.getParentsInstances()) {
            String nomeComponente = pai.getComponentInstanceName();
            result.include(nomeComponente, pai);
            System.out.println("O componente antecessor " + pai.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }
}
