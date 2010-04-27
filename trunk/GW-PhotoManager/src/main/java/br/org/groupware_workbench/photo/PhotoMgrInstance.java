package br.org.groupware_workbench.photo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import br.com.caelum.vraptor.core.RequestInfo;
import br.org.groupware_workbench.collabletFw.facade.CollabletInstance;
import br.org.groupware_workbench.coreutils.DAOFactory;
import br.org.groupware_workbench.photo.internal.PhotoDAO;

public class PhotoMgrInstance extends CollabletInstance {
	private PhotoDAO dao = DAOFactory.get(PhotoDAO.class);;
	private String dirImagesRelativo = "images";
	private	String thumbPrefix="thumb_";
	private String mostraPrefix="mostra_";
	private  String dirImagesAbsoluto = null;		

	public PhotoMgrInstance() {		
		super();
		this.thumbPrefix="thumb_";
		this.mostraPrefix="mostra_";		
	}

	public void setRequestInfo(RequestInfo info){
		dirImagesAbsoluto=info.getServletContext().getRealPath("/")+dirImagesRelativo+File.separator;		
	}
	
	
	@Override
	public void destroy() {
		//TODO modify this according with the objectDAO, ask victor or geiser
		//this.dao.deleteByIdInstance(this.getId());
	}
	
	
	public void save(Photo photoRegister) {
		photoRegister.setIdInstance(this.getId());
		
		//TODO modify this according with the objectDAO, ask victor or geiser
		this.dao.save(photoRegister,true);
	}

	public void saveImage(InputStream foto, String nome)throws IOException {
		this.dao.saveImage(foto, nome, dirImagesAbsoluto);	
	}

	public List<Photo> buscaFoto(String busca) {
		return this.dao.busca(busca,this.getId());							
	}
	
	public List<Photo> buscaFotoAvancada(String nome, String descricao, String lugar, Date date) {
		return this.dao.busca(nome,lugar,descricao,date,this.getId());							
	}
	
	public Photo buscaPhotoById(long idPhoto){
		return this.dao.findById(idPhoto);		
	}
	
	public List<Photo> listaTodaPhoto(){
		//TODO deve listar so de uma instancia so
		return dao.listAll();	
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
}
