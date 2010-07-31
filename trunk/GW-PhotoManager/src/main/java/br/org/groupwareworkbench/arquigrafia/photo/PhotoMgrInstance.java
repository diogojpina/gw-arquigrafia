package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.DAOFactory;
import br.org.groupwareworkbench.core.bd.GenericEntity;
import br.org.groupwareworkbench.core.framework.Business;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.ComponentInfo;

@ComponentInfo(
    version="0.1",
    configurationURL="/groupware-workbench/{photoInstance}/photo",
    rootLevel=true
)
public class PhotoMgrInstance implements Business {

    private final PhotoDAO dao = DAOFactory.get(PhotoDAO.class);
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
        return this.dao.getImageFile(getDirImages(), this.getThumbPrefix(), nomeArquivoUnico);        
    }

    public File imgCrop(String nomeArquivoUnico) {
        return this.dao.getImageFile(getDirImages(), this.getCropPrefix(), nomeArquivoUnico);        
    }

    public File imgShow(String nomeArquivoUnico) {
        return this.dao.getImageFile(getDirImages(), this.getMostraPrefix(), nomeArquivoUnico);        
    }

    public File imgOriginal(String nomeArquivoUnico) {
        return this.dao.getImageFile(getDirImages(), "", nomeArquivoUnico);
    }

    //@Override
    public void destroy() {
        this.dao.deleteByIdInstance(collablet.getId());
    }

    public void delete(long photoId) {
        dao.deleteById(photoId);
    }

    public void save(Photo photoRegister) {
        photoRegister.setIdInstance(collablet.getId());
        this.dao.save(photoRegister, true);
    }

    public void assignToUser(Photo photoRegister, User user) {
        this.dao.assignToUser(photoRegister.getId(), user.getId());
    }
    
    public void saveImage(InputStream foto, String nome) throws IOException {
        this.dao.saveImage(foto, nome, this.getDirImages());
    }

    public List<Photo> buscaFoto(String busca) {
        return this.dao.busca(busca);
    }

    public List<Photo> buscaFotoAvancada(String nome, String descricao, String lugar, Date date) {
        return this.dao.busca(nome, lugar, descricao, date);
    }

    public Photo buscaPhotoById(long idPhoto) {
        return this.dao.findById(idPhoto);
    }

    // TODO a existência de este método é temporal até encontrar uma melhor solução para o componente de avaliação   
    public Photo findById(long idPhoto) {
        return this.dao.findById(idPhoto);
    }
    
    public List<Photo> buscaFotoPorListaId(List<GenericEntity> idList) {
        List<Photo> photos = new ArrayList<Photo>();
        for (GenericEntity entity : idList) {
            if (entity instanceof Photo) {
                photos.add((Photo) entity);
            }
        }
        return photos;
    }

    public List<Photo> listaTodaPhoto() {
        return dao.listAll();
    }

    public List<Photo> listaPhotoPorPaginaEOrdem(int tamanho, int pagina) {
        return dao.listPhotoByPageAndOrder(tamanho, pagina);
    }

    public List<Photo> list() {
        return dao.listByIdInstance(collablet.getId());
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
