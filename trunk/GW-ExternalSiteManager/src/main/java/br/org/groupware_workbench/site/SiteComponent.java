package br.org.groupware_workbench.site;

import br.org.groupware_workbench.collabletFw.facade.Collablet;
import br.org.groupware_workbench.coreutils.ComponentInfo;

@ComponentInfo(instanceType=SiteInstance.class, 
    version="0.1",
    configurationURL="/groupware-workbench/{siteInstance}/site"
)
public class SiteComponent extends Collablet {

}
