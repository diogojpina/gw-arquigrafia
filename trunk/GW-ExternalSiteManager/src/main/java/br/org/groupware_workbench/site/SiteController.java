package br.org.groupware_workbench.site;

import javax.servlet.http.HttpServletRequest;

import org.omg.CosNaming.NameComponent;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupware_workbench.collabElementFw.facade.CollabElementInstance;
import br.org.groupware_workbench.groupwareComponentFwFw.facade.Component;
import br.org.groupware_workbench.groupwareComponentFwFw.facade.ComponentInstance;

@RequestScoped
@Resource
public class SiteController {

	private Result result;
	private HttpServletRequest request;
	private Validator validator;
	private RequestInfo info;	


	public SiteController(Result result, Validator validator, HttpServletRequest request,RequestInfo info) {
		this.result = result;
		this.validator=validator;		
		this.request = request;
		this.info=info;	
	}
	
	@Get
	@Path(value = "/groupware-workbench/{siteInstance}/pages")
	public void index(SiteInstance siteInstance){		
		//addIncludes();		
		result.include("siteInstance", siteInstance);
		for (Component component : siteInstance.getComponent().getGroup().getComponents()) {
			String componentName = component.getCod();
			componentName = componentName.replaceAll("/", "_").toLowerCase();
			ComponentInstance componentInstance;
			if (component.hasInstance()) {
				componentInstance = component.getInstances().iterator().next();
			}
			else {
				componentInstance = component.makeNewInstance();
			}
			result.include(componentName, componentInstance);
			System.out.println("Adicionado " + componentName);
		}
		for (CollabElementInstance collabComponentInstance : siteInstance.getCollabElementInstances()) {
			String nomeComponente = collabComponentInstance.getName();
			result.include(nomeComponente, collabComponentInstance);
			System.out.println("O componente " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
		}
	}
	
}
