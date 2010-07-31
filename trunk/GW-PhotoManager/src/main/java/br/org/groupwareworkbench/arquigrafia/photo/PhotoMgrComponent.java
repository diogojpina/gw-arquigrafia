package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Node;

import br.org.groupwareworkbench.core.framework.ComponentInfo;
import br.org.groupwareworkbench.core.framework.Component;

@ComponentInfo(
    instanceType=PhotoMgrInstance.class,
    version="0.1",
    configurationURL="/groupware-workbench/{photoInstance}/photo",
    rootLevel=true
)
@Deprecated
public class PhotoMgrComponent extends Component {

    private String dirImages = "images";
    private String cropPrefix = "crop_";
    private String thumbPrefix = "thumb_";
    private String mostraPrefix = "mostra_";

    public PhotoMgrComponent() {
    }

    @SuppressWarnings("unchecked")
    @Override
    protected void applyConfiguration(Element xml, boolean isInstalling) {
        Document doc = xml.getDocument();
        List<Node> imageDirectory = doc.selectNodes("//collablet/specific-configuration/image-directory");
        List<Node> show = doc.selectNodes("//collablet/specific-configuration/show-prefix");
        List<Node> crop = doc.selectNodes("//collablet/specific-configuration/crop-prefix");
        List<Node> thumb = doc.selectNodes("//collablet/specific-configuration/thumbnail-prefix");

        if (imageDirectory != null) {
            dirImages = imageDirectory.get(0).valueOf("@value") + File.separator;
            File dir = new File(dirImages);
            if (!dir.exists()) {
                dir.mkdir();
            }
        }
        if (show != null) {
            mostraPrefix = show.get(0).valueOf("@value");
        }
        if (crop != null) {
            cropPrefix = crop.get(0).valueOf("@value");
        }
        if (thumb != null) {
            thumbPrefix = thumb.get(0).valueOf("@value");
        }
    }

    public String getDirImages() {
        return dirImages;
    }

    public String getCropPrefix() {
        return cropPrefix;
    }

    public String getThumbPrefix() {
        return thumbPrefix;
    }

    public String getMostraPrefix() {
        return mostraPrefix;
    }
}