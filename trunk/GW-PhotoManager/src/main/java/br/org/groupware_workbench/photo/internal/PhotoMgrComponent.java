package br.org.groupware_workbench.photo.internal;

import br.org.groupware_workbench.collabletFw.facade.Collablet;
import br.org.groupware_workbench.coreutils.ComponentInfo;
import br.org.groupware_workbench.photo.PhotoMgrInstance;


@ComponentInfo(instanceType=PhotoMgrInstance.class, 
    version="0.1",
    configurationURL="/groupware-workbench/{photoInstance}/photo"
)
public class PhotoMgrComponent extends Collablet {

}
