package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Business;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;

@ComponentInfo(
    version="0.1",
    configurationURL="/groupware-workbench/{photoInstance}/photo"
)
public class PhotoMgrInstance implements Business {

    private final Collablet collablet;

    // TODO: Converter em atributos.
    private final String dirImages = "images";
    private final String cropPrefix = "crop_";
    private final String thumbPrefix = "thumb_";
    private final String mostraPrefix = "mostra_";

    public PhotoMgrInstance(Collablet collablet) {
        this.collablet = collablet;
    }

    public Collablet getCollablet() {
        return collablet;
    }

    public Long getId() {
        return collablet.getId();
    }

    public File imgThumb(String nomeArquivoUnico) {
        return Photo.getImageFile(getDirImages(), this.getThumbPrefix(), nomeArquivoUnico);        
    }

    public File imgCrop(String nomeArquivoUnico) {
        return Photo.getImageFile(getDirImages(), this.getCropPrefix(), nomeArquivoUnico);        
    }

    public File imgShow(String nomeArquivoUnico) {
        return Photo.getImageFile(getDirImages(), this.getMostraPrefix(), nomeArquivoUnico);        
    }

    public File imgOriginal(String nomeArquivoUnico) {
        return Photo.getImageFile(getDirImages(), "", nomeArquivoUnico);
    }

    //@Override
    public void destroy() {
        Photo.deleteAll(collablet);
    }

    public void delete(Photo photo) {
        photo.setCollablet(collablet);
        photo.delete();
    }

    public void save(Photo photo) {
        photo.setCollablet(collablet);
        photo.save();
    }

    public void assignToUser(Photo photo, User user) {
        photo.assignUser(user);
        
    }

    public void saveImage(InputStream foto, String nome) throws IOException {
        Photo.saveImage(foto, nome, this.getDirImages());
    }

    public List<Photo> buscaFoto(String busca) {
        return Photo.busca(collablet, busca);
    }

    public List<Photo> buscaFotoAvancada(String nome, String descricao, String lugar, Date date) {
        return Photo.busca(collablet, nome, lugar, descricao, date);
    }
       
    public List<Photo> buscaFotoPorListaId(List<Object> listObjects) {
        List<Photo> photos = new ArrayList<Photo>();
        for (Object object : listObjects) {
            if (object instanceof Photo) {
                photos.add((Photo) object);
            }
        }
        return photos;
    }

    public List<Photo> list() {
        return Photo.list(collablet);
    }

    public List<Photo> listPhotoByPageAndOrder(int pageSize, int pageNumber) {
        return Photo.listPhotoByPageAndOrder(collablet, pageSize, pageNumber);        
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

    public String getDirImagesAbsoluto() {
        return this.getDirImages();
    }
}
