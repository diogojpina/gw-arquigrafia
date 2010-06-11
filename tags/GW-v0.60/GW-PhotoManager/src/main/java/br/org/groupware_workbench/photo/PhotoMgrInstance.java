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
import br.org.groupware_workbench.photo.internal.PhotoDAO;

public class PhotoMgrInstance extends CollabletInstance {

	private final PhotoDAO dao = DAOFactory.get(PhotoDAO.class);

	// TODO: Não deve haver estado mutável transiente nesta classe, visto que ela é compartilhada entre diferentes
	// Threads.
	private String dirImagesRelativo = "images";
	private String cropPrefix = "crop_";
	private	String thumbPrefix = "thumb_";
	private String mostraPrefix = "mostra_";
	private String dirImagesAbsoluto = null;

	public PhotoMgrInstance() {
		super();
		this.thumbPrefix = "thumb_";
		this.setCropPrefix("crop_");
		this.mostraPrefix = "mostra_";
	}

	public void setRequestInfo(RequestInfo info) {
		dirImagesAbsoluto = info.getServletContext().getRealPath("/") + dirImagesRelativo + File.separator;
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
	
	public List<Photo> listaPrimeirasCem() {
        return dao.listPhotoByPageAndOrder(100,0);
    }

	public String getDirImagesRelativo() {
		return dirImagesRelativo;
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

	public void setDirImagesRelativo(String dirImagesRelativo) {
		this.dirImagesRelativo = dirImagesRelativo;
	}

	public String getDirImagesAbsoluto() {
		return dirImagesAbsoluto;
	}

	public void setCropPrefix(String cropPrefix) {
		this.cropPrefix = cropPrefix;
	}

	public String getCropPrefix() {
		return cropPrefix;
	}
}