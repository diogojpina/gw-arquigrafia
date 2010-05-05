package br.org.groupware_workbench.site.internal;


import br.org.groupware_workbench.collabletFw.facade.Collablet;
import br.org.groupware_workbench.coreutils.ComponentInfo;
import br.org.groupware_workbench.site.SiteInstance;

@ComponentInfo(instanceType=SiteInstance.class, 
    version="0.1",
    configurationURL = "/groupware-workbench/{siteInstance}/pages"
)
public class SiteComponent extends Collablet {

}
