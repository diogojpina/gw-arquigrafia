package br.org.groupware_workbench.photo;

import java.awt.Dimension;
import java.awt.Point;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.org.groupware_workbench.collabElementFw.facade.CollabElementInstance;
import br.org.groupware_workbench.commons.util.ImageUtils;

@RequestScoped
@Resource
public class PhotoController {
	
	private Result result;
	private HttpServletRequest request;
	private Validator validator;
	private List<Photo> resultFotosBusca;
	private RequestInfo info;	


	public PhotoController(Result result, Validator validator, HttpServletRequest request,RequestInfo info) {
		this.result = result;
		this.validator=validator;		
		this.request = request;
		this.info=info;		
	}
				
	
	@Get
	@Path(value = "/groupware-workbench/{photoInstance}/photo/show/{idPhoto}")
	public void show(PhotoMgrInstance photoInstance, long idPhoto){	
		photoInstance.setRequestInfo(info);
		result.include("idPhoto",idPhoto);		
		//addIncludes();
		result.include("photoInstance", photoInstance);
		for (CollabElementInstance collabComponentInstance : photoInstance.getCollabElementInstances()) {
			String nomeComponente = collabComponentInstance.getName();
			result.include(nomeComponente, collabComponentInstance);
			System.out.println("O componente " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
		}
		
	}
	
	
	@Get
	@Path(value = "/groupware-workbench/{photoInstance}/photo")
	public void busca(PhotoMgrInstance photoInstance){		
		//addIncludes();		
		result.include("photoInstance", photoInstance);
		for (CollabElementInstance collabComponentInstance : photoInstance.getCollabElementInstances()) {
			String nomeComponente = collabComponentInstance.getName();
			result.include(nomeComponente, collabComponentInstance);
			System.out.println("O componente " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
		}
	}
	
	@Post
	@Path(value = "/groupware-workbench/{photoInstance}/photo/busca")
	public void buscaFoto(String busca, PhotoMgrInstance photoInstance){	
		if(busca.length()<3){
			validator.add(new ValidationMessage("Minimo 3 letras","Erro"));			
			validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
			return;
		}		

		@SuppressWarnings("unchecked") // Cast desnecessário no Java EE 6. Necessário no Java EE 5.
		Map<String, String[]> params = (Map<String, String[]>) request.getParameterMap();
            for (CollabElementInstance instance : photoInstance.getCollabElementInstances()) {
			String nome = instance.getName();
			Map<String, String[]> collabParams = new HashMap<String, String[]>();
			for (Map.Entry<String, String[]> param : params.entrySet()) {
				String paramName = param.getKey();
				if (!paramName.startsWith(nome + ".")) continue;
				collabParams.put(paramName.substring(nome.length() + 1), param.getValue());
			}			
		}
						
		resultFotosBusca=photoInstance.buscaFoto(busca);	
		
		result.include("fotos",resultFotosBusca);
		result.include("thumbPrefix", photoInstance.getThumbPrefix());
		result.include("cropPrefix", photoInstance.getCropPrefix());
		result.include("mostraPrefix",photoInstance.getMostraPrefix());
		result.include("dirImagem", photoInstance.getDirImagesRelativo());
		result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
	}
	
	@Post
	@Path(value = "/groupware-workbench/{photoInstance}/photo/buscaA")
	public void buscaFotoAvanzada(String nome, String descricao, String lugar, Date date,PhotoMgrInstance photoInstance ){	
		if(nome.equals("") && descricao.equals("") && lugar.equals("") && date==null){
			validator.add(new ValidationMessage("Nenhum campo prechido","Erro"));
			//validator.onErrorUse(Results.page()).redirect("/groupware-workbench/"+idCollabletInstance+"/photo");
			validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
			return;
		}		
		

		@SuppressWarnings("unchecked") // Cast desnecessário no Java EE 6. Necessário no Java EE 5.
		Map<String, String[]> params = (Map<String, String[]>) request.getParameterMap();

            for (CollabElementInstance instance : photoInstance.getCollabElementInstances()) {
			String nomeI = instance.getName();
			Map<String, String[]> collabParams = new HashMap<String, String[]>();
			for (Map.Entry<String, String[]> param : params.entrySet()) {
				String paramName = param.getKey();
				if (!paramName.startsWith(nomeI + ".")) continue;
				collabParams.put(paramName.substring(nomeI.length() + 1), param.getValue());
			}		
		}
				
		resultFotosBusca=photoInstance.buscaFotoAvancada(nome,lugar,descricao,date);			
		result.include("fotos",resultFotosBusca);
		result.include("thumbPrefix", photoInstance.getThumbPrefix());
		result.include("cropPrefix", photoInstance.getCropPrefix());
		result.include("dirImagem", photoInstance.getDirImagesRelativo());
		result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);		
	}
	

	@Get
	@Path(value = "/groupware-workbench/{photoInstance}/photo/registra")
	public void registra(PhotoMgrInstance photoInstance) {
		//addIncludes();		
		
		result.include("photoInstance", photoInstance);
		for (CollabElementInstance collabComponentInstance : photoInstance.getCollabElementInstances()) {
			String nomeComponente = collabComponentInstance.getName();
			result.include(nomeComponente, collabComponentInstance);
			System.out.println("O componente " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
		}
		
	}		

	@Post
	@Path(value = "/groupware-workbench/{photoInstance}/photo/registra")
	public void save(Photo photoRegister, UploadedFile foto, PhotoMgrInstance photoInstance) {
		//validaçoes:
		photoInstance.setRequestInfo(info);
		boolean flag=false;
		if(photoRegister.getNome().equals("")){			
			validator.add(new ValidationMessage("O nome é obrigatorio","Erro"));			
			flag=true;
		}
		
		if(foto==null){
			validator.add(new ValidationMessage("Uma imagem é obrigatoria","Erro"));
			flag=true;	
		}
	    if(flag){	       
	       //validator.onErrorUse(Results.page()).redirect("/groupware-workbench/"+idCollabletInstance+"/photo/registra");
	       validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
		   return;
	    }
	    //fim das validaçoes
					
		String nomeArquivo = foto.getFileName();
		photoRegister.setNomeArquivo(nomeArquivo);

		InputStream imagenOriginal=null;
		InputStream imagenThumb=null;
		InputStream imagenCropped = null;
		InputStream imagenMostra=null;

		try {
			imagenOriginal = foto.getFile();
			imagenMostra = ImageUtils.createThumbnail(new Dimension(800, 600), imagenOriginal);
			imagenOriginal.reset();
			imagenThumb = ImageUtils.createThumbnail(new Dimension(100, 100), imagenOriginal);
			imagenOriginal.reset();
			imagenCropped = ImageUtils.cropImage(ImageUtils.calcSqrThumbCropPoint(imagenOriginal), 
													new Dimension(100,100), imagenOriginal);
		} catch (Exception e) {
			//e.printStackTrace();
			validator.add(new ValidationMessage("Não foi possivel escalar a imagen","Erro"));
			validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);			
			return;
		}
					
		try{			
		photoInstance.save(photoRegister);				
		photoInstance.saveImage(imagenOriginal, nomeArquivo);
		photoInstance.saveImage(imagenCropped, photoInstance.getCropPrefix() + nomeArquivo);
		photoInstance.saveImage(imagenThumb,photoInstance.getThumbPrefix()+nomeArquivo);			
		photoInstance.saveImage(imagenMostra,photoInstance.getMostraPrefix()+nomeArquivo);
		
		} catch (Exception e) {
			e.printStackTrace();
			validator.add(new ValidationMessage("Falha ao fazer o upload da imagem","Erro"));
			//validator.onErrorUse(Results.page()).redirect("/groupware-workbench/"+idCollabletInstance+"/photo/registra");
			validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
			return;					
		}
		
		
		
		@SuppressWarnings("unchecked") // Cast desnecessário no Java EE 6. Necessário no Java EE 5.
		Map<String, String[]> params = (Map<String, String[]>) request.getParameterMap();

            for (CollabElementInstance instance : photoInstance.getCollabElementInstances()) {
			String nome = instance.getName();
			Map<String, String[]> collabParams = new HashMap<String, String[]>();
			for (Map.Entry<String, String[]> param : params.entrySet()) {
				String paramName = param.getKey();
				if (!paramName.startsWith(nome + ".")) continue;
				collabParams.put(paramName.substring(nome.length() + 1), param.getValue());
			}
			instance.saveWidgets(collabParams, photoRegister.getId());
		}
				
		result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
	}
	
	
	@Delete
	@Path(value = "/groupware-workbench/{photoInstance}/photo/show/{idPhoto}")	
	public void delete(PhotoMgrInstance photoInstance, long idPhoto){
		if(idPhoto<1){
			validator.add(new ValidationMessage("Não é uma entidade valida","Erro"));
			return;
		}		
		photoInstance.delete(idPhoto);		
	}

}
