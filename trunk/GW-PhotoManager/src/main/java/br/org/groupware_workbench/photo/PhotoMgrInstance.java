package br.org.groupware_workbench.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import br.com.caelum.vraptor.core.RequestInfo;
import br.org.groupware_workbench.collabletFw.facade.CollabletInstance;
import br.org.groupware_workbench.coreutils.DAOFactory;
import br.org.groupware_workbench.coreutils.GenericEntity;

public class PhotoMgrInstance extends CollabletInstance {

    private final PhotoDAO dao = DAOFactory.get(PhotoDAO.class);

    // TODO: Não deve haver estado mutável transiente nesta classe, visto que ela é compartilhada entre diferentes
    // Threads.
    
    private String dirImagesAbsoluto = null;

    public PhotoMgrInstance() {
        super();
    }

    public void setRequestInfo(RequestInfo info) {
        if(dirImagesAbsoluto==null){
            dirImagesAbsoluto = info.getServletContext().getRealPath("/") + this.getDirImagesRelativo() + File.separator;
            File dir=new File(dirImagesAbsoluto);
            if(!dir.exists()){
                dir.mkdir();
            }
        }
    }

    @Override
    public void destroy() {
        this.dao.deleteByIdInstance(this.getId());
    }

    public void delete(long photoId) {
        dao.deleteById(photoId);
    }

    public void save(Photo photoRegister) {
        photoRegister.setIdInstance(this.getId());
        this.dao.save(photoRegister, true);
    }

    public void saveImage(InputStream foto, String nome) throws IOException {
        this.dao.saveImage(foto, nome, dirImagesAbsoluto);
    }

    public List<Photo> buscaFoto(String busca) {
        return this.dao.busca(busca,this.getId());
    }

    public List<Photo> buscaFotoAvancada(String nome, String descricao, String lugar, Date date) {
        return this.dao.busca(nome, lugar, descricao, date, this.getId());
    }

    public Photo buscaPhotoById(long idPhoto) {
        return this.dao.findById(idPhoto);
    }

    public List<Photo> buscaFotoPorListaId(List<GenericEntity> idList) {
        return this.dao.buscaPorID(idList, this.getId());
    }

    public List<Photo> listaTodaPhoto() {
        return dao.listAll();
    }
    
    public List<Photo> listaPhotoPorPaginaEOrdem(int tamanho, int pagina) {
        return dao.listPhotoByPageAndOrder(tamanho,pagina);
    }

    public String getDirImagesRelativo() {      
        return ((PhotoMgrComponent)this.getComponent()).getDirImages();
    }

    public String getThumbPrefix() {        
        return ((PhotoMgrComponent)this.getComponent()).getThumbPrefix();
    }

    public String getMostraPrefix() {
        return ((PhotoMgrComponent)this.getComponent()).getMostraPrefix();      
    }
    
    public String getDirImagesAbsoluto() {      
        return dirImagesAbsoluto;
    }

    public String getCropPrefix() {     
        return ((PhotoMgrComponent)this.getComponent()).getCropPrefix();
    }
}
