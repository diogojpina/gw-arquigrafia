package br.org.groupwareworkbench.arquigrafia.site;

import br.org.groupwareworkbench.core.framework.ComponentInfo;
import br.org.groupwareworkbench.core.framework.Component;

@ComponentInfo(instanceType=SiteInstance.class, 
    version="0.1",
    configurationURL="/groupware-workbench/{siteInstance}/site",
    rootLevel=true
)
public class SiteComponent extends Component {

}
