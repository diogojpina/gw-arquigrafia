package br.org.groupware_workbench.site;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupware_workbench.collabElementFw.facade.CollabElementInstance;
import br.org.groupware_workbench.groupwareComponentFwFw.facade.Component;
import br.org.groupware_workbench.groupwareComponentFwFw.facade.ComponentInstance;

@RequestScoped
@Resource
public class SiteController {

    private final Result result;
    private final HttpServletRequest request;

    public SiteController(Result result, HttpServletRequest request) {
        this.result = result;
        this.request = request;
    }

    @Get
    @Path(value="/groupware-workbench/{siteInstance}/site")
    public void index(SiteInstance siteInstance) {
        //addIncludes();
        result.include("siteInstance", siteInstance);
        this.request.getSession().setAttribute("siteInstance", siteInstance);
        for (Component component : siteInstance.getComponent().getGroup().getComponents()) {
            String componentName = component.getCod();
            componentName = componentName.replaceAll("/", "_").toLowerCase();
            ComponentInstance componentInstance;
            if (component.hasInstance()) {
                componentInstance = component.getInstances().iterator().next();
            } else {
                componentInstance = component.makeNewInstance(); // TODO: Não fazer isso. Esse método deveria ser privado do core.
            }
            result.include(componentName, componentInstance);
            this.request.getSession().setAttribute(componentName, componentInstance); // TODO: Não fazer isso, apenas oculta bugs.
            System.out.println("Adicionado " + componentName);
        }
        for (CollabElementInstance collabComponentInstance : siteInstance.getCollabElementInstances()) {
            String nomeComponente = collabComponentInstance.getName();
            result.include(nomeComponente, collabComponentInstance);
            this.request.getSession().setAttribute(nomeComponente, collabComponentInstance); // TODO: Não fazer isso, apenas oculta bugs.
            System.out.println("O componente " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }
}
