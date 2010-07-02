package br.org.groupware_workbench.site;

import br.org.groupware_workbench.coreutils.ComponentInfo;
import br.org.groupware_workbench.groupwareComponentFwFw.facade.Component;

@ComponentInfo(instanceType=SiteInstance.class, 
    version="0.1",
    configurationURL="/groupware-workbench/{siteInstance}/site",
    rootLevel=true
)
public class SiteComponent extends Component {

}
