package br.org.groupware_workbench.photo;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

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
import br.org.groupware_workbench.collabletFw.facade.CollabletInstance;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

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
		InputStream imagenMostra=null;

		try {
			imagenOriginal = foto.getFile();
			imagenMostra = PhotoController.scaleImage(imagenOriginal,800, 600);
			imagenOriginal.reset();
			imagenThumb = PhotoController.scaleImage(imagenOriginal,100, 100);
			imagenOriginal.reset();		
		} catch (Exception e) {
			//e.printStackTrace();
			validator.add(new ValidationMessage("Não foi possivel escalar a imagen","Erro"));
			validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);			
			return;
		}
					
		try{			
		photoInstance.save(photoRegister);				
		photoInstance.saveImage(imagenOriginal, nomeArquivo);
		
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
	
	
	private void addIncludes() {
		
	}
	

	public static InputStream scaleImage(InputStream p_image, int p_width,
			int p_height) throws Exception {
		InputStream imageStream = new BufferedInputStream(p_image);
		Image image = (Image) ImageIO.read(imageStream);

		int thumbWidth = p_width;
		int thumbHeight = p_height;

		// Make sure the aspect ratio is maintained, so the image is not skewed
		double thumbRatio = (double) thumbWidth / (double) thumbHeight;
		int imageWidth = image.getWidth(null);
		int imageHeight = image.getHeight(null);
		double imageRatio = (double) imageWidth / (double) imageHeight;
		if (thumbRatio < imageRatio) {
			thumbHeight = (int) (thumbWidth / imageRatio);
		} else {
			thumbWidth = (int) (thumbHeight * imageRatio);
		}

		// Draw the scaled image
		BufferedImage thumbImage = new BufferedImage(thumbWidth, thumbHeight,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D graphics2D = thumbImage.createGraphics();
		graphics2D.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
				RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		graphics2D.drawImage(image, 0, 0, thumbWidth, thumbHeight, null);

		// Write the scaled image to the outputstream
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(thumbImage);
		int quality = 100; // Use between 1 and 100, with 100 being highest
							// quality
		quality = Math.max(0, Math.min(quality, 100));
		param.setQuality((float) quality / 100.0f, false);
		encoder.setJPEGEncodeParam(param);
		encoder.encode(thumbImage);
		ImageIO.write(thumbImage, "jpg", out);

		// Read the outputstream into the inputstream for the return value
		ByteArrayInputStream bis = new ByteArrayInputStream(out.toByteArray());
		return bis;
	}
}
