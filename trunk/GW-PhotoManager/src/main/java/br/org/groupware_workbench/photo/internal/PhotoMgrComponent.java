package br.org.groupware_workbench.photo.internal;

import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;

import br.org.groupware_workbench.collabletFw.facade.Collablet;
import br.org.groupware_workbench.coreutils.ComponentInfo;
import br.org.groupware_workbench.photo.PhotoMgrInstance;


@ComponentInfo(instanceType=PhotoMgrInstance.class, 
    version="0.1",
    configurationURL="/groupware-workbench/{photoInstance}/photo"
)
public class PhotoMgrComponent extends Collablet {
    private String dirImages = "images";
    private String cropPrefix = "crop_";
    private String thumbPrefix = "thumb_";
    private String mostraPrefix = "mostra_";
           
    public PhotoMgrComponent(){
                
    }
    
    @SuppressWarnings({"unchecked", "null"})
    @Override
    protected void applyConfiguration(Element xml, boolean isInstalling){
        Document doc=xml.getDocument();        
        List<Node> imageDirectory=doc.selectNodes("//collablet/specific-configuration/image-directory");        
        List<Node> show=doc.selectNodes("//collablet/specific-configuration/show-prefix");
        List<Node> crop=doc.selectNodes("//collablet/specific-configuration/crop-prefix");
        List<Node> thumb=doc.selectNodes("//collablet/specific-configuration/thumbnail-prefix");
        
        if(imageDirectory!=null){
            dirImages=imageDirectory.get(0).valueOf("@value");
        }
        if(show!=null){
            mostraPrefix=show.get(0).valueOf("@value");
        }
        if(crop!=null){
            cropPrefix=crop.get(0).valueOf("@value");
        }
        if(thumb!=null){
            thumbPrefix=thumb.get(0).valueOf("@value");
        }                      
    }

    public String getDirImages() {
        return dirImages;
    }

    public void setDirImages(String dirImages) {
        this.dirImages = dirImages;
    }

    public String getCropPrefix() {
        return cropPrefix;
    }

    public void setCropPrefix(String cropPrefix) {
        this.cropPrefix = cropPrefix;
    }

    public String getThumbPrefix() {
        return thumbPrefix;
    }

    public void setThumbPrefix(String thumbPrefix) {
        this.thumbPrefix = thumbPrefix;
    }

    public String getMostraPrefix() {
        return mostraPrefix;
    }

    public void setMostraPrefix(String mostraPrefix) {
        this.mostraPrefix = mostraPrefix;
    }

}
