package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.download.FileDownload;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;

@Resource
public class ComponentRepositoryController {
	private final Result result;
	private final Validator validator;
	private final RequestInfo info;

	public ComponentRepositoryController(final Validator validator, final Result result, final RequestInfo info){
		this.result = result;
		this.validator = validator;
		this.info = info;
	}
	
	private void validateComponent(final Component component) {
		final String componentName = component.getName();
		final String componentVersion = component.getVersion();
		String urlEncodedName = null;
		String urlEncodedVersion = null;
		
		try{
			urlEncodedName = URLEncoder.encode(componentName, "UTF-8");
			urlEncodedVersion = URLEncoder.encode(componentVersion, "UTF-8");
		}catch (UnsupportedEncodingException e) {
			//Not possible
		}
		
		//Validação do nome
		if(componentName.isEmpty()){
			validator.add(new ValidationMessage("Nome do componente não informado.", "Dados incompletos"));
		}else if(componentName.length() > 50){
			validator.add(new ValidationMessage("Nome do componente deve ter no máximo 50 caracteres.", "Dados inválidos"));
		}else if(!componentName.equals(urlEncodedName)){
			validator.add(new ValidationMessage("Nome do componente deve conter apenas os caracteres a-zA-Z0-9.-_*.", "Dados inválidos"));
		}
		//Validação da descrição
		if(component.getDescription().length() > 255){
			validator.add(new ValidationMessage("Descrição do componente deve ter no máximo 255 caracteres.", "Dados inválidos"));
		}
		//Validação da ação
		if(component.getAction().isEmpty()){
            validator.add(new ValidationMessage("Ação do componente não informado.", "Dados incompletos"));
		}else if(component.getAction().length() > 255){
            validator.add(new ValidationMessage("Ação do componente deve ter no máximo 255 caracteres.", "Dados inválidos"));
        }
		//Validação do package
        if(component.getPackageName().isEmpty()){
            validator.add(new ValidationMessage("Pacote do componente não informado.", "Dados incompletos"));
        }else if(component.getPackageName().length() > 255){
            validator.add(new ValidationMessage("Pacote do componente deve ter no máximo 255 caracteres.", "Dados inválidos"));
        }
		//Validação da versão
		if(componentVersion.length() > 10){
			validator.add(new ValidationMessage("Versão do componente deve ter no máximo 10 caracteres.", "Dados inválidos"));
		}else if(!componentVersion.equals(urlEncodedVersion)){
			validator.add(new ValidationMessage("Versão do componente deve conter apenas os caracteres a-zA-Z0-9.-_*.", "Dados inválidos"));
		}
	}
	
	private void validateComponentFile(final UploadedFile componentFile) {
		if(componentFile == null){
			validator.add(new ValidationMessage("Nenhum arquivo enviado.", "Dados incompletos"));
		}else{
			//Validação do nome
			final String componentFileName = componentFile.getFileName();
//			final String componentFileType = componentFile.getContentType();

			//Removida a validação por MIME-TYPE já que alguns browsers não enviam o tipo corretamente
			if(!componentFileName.toLowerCase().endsWith("apk")){
			    validator.add(new ValidationMessage("Nome do arquivo enviado inválido. Envie um arquivo com extensão APK.", "Dados inválidos"));
            }
		}
	}
	
	@SuppressWarnings("cast")
    private void addIncludes(ComponentRepositoryInstance componentRepositoryInstance){
	    result.include("componentRepository", componentRepositoryInstance);
	    result.include("photoMgr", (PhotoMgrInstance)componentRepositoryInstance.getCollablet().getParent().getBusinessObject());
	}
	
	private List<Component> registerComponents(ComponentRepositoryInstance componentRepositoryInstance){
	    try{
            String componentRootPath = info.getServletContext().getRealPath("/WEB-INF/repository");
            new File(componentRootPath).mkdirs();

            Component binomial = new Component();
            binomial.setName("Binomial");
            binomial.setDescription("Gerenciador de binômios.");
            binomial.setVersion("0.9b");
            binomial.setAction("br.ufes.cwtools.gw.android.GWA_BINOMIAL");
            binomial.setPackageName("br.ufes.cwtools.gw.android.components.binomial");
            ComponentFile binomialFile = new ComponentFile(new File(componentRootPath + "/GWA-Binomial.apk"));
            
            Component gallery = new Component();
            gallery.setName("Gallery");
            gallery.setDescription("Exibe a galeria de fotos.");
            gallery.setVersion("0.9b");
            gallery.setAction("br.ufes.cwtools.gw.android.GWA_GALLERY");
            gallery.setPackageName("br.ufes.cwtools.gw.android.components.gallery");
            ComponentFile galleryFile = new ComponentFile(new File(componentRootPath + "/" + "GWA-Gallery.apk"));
            
            Component imageUpload = new Component();
            imageUpload.setName("ImageUpload");
            imageUpload.setDescription("Envia fotos para o servidor.");
            imageUpload.setVersion("0.9b");
            imageUpload.setAction("br.ufes.cwtools.gw.android.GWA_IMAGE_UPLOAD#br.ufes.cwtools.gw.android.GWA_IMAGE_PICKER");
            imageUpload.setPackageName("br.ufes.cwtools.gw.android.components.image_upload");
            ComponentFile imageUploadFile = new ComponentFile(new File(componentRootPath + "/" + "GWA-ImageUpload.apk"));
            
            Component map = new Component();
            map.setName("Map");
            map.setDescription("Mapa para exibição de usuários e objetos.");
            map.setVersion("0.9b");
            map.setAction("br.ufes.cwtools.gw.android.GWA_MAP");
            map.setPackageName("br.ufes.cwtools.gw.android.components.map");
            ComponentFile mapFile = new ComponentFile(new File(componentRootPath + "/" + "GWA-Map.apk"));
            
            Component tracker = new Component();
            tracker.setName("Tracker");
            tracker.setDescription("Localizador de usuários móveis.");
            tracker.setVersion("0.9b");
            tracker.setAction("br.ufes.cwtools.gw.android.GWA_TRACKER");
            tracker.setPackageName("br.ufes.cwtools.gw.android.components.tracker");
            ComponentFile trackerFile = new ComponentFile(new File(componentRootPath + "/" + "GWA-Tracker.apk"));
            
            Component joinus = new Component();
            joinus.setName("JoinUs!");
            joinus.setDescription("JoinUs! - rede social móvel.");
            joinus.setVersion("1.9b");
            joinus.setAction("br.ufes.cwtools.gw.android.GWA_JOINUS");
            joinus.setPackageName("br.ufes.cwtools.joinus");
            ComponentFile joinusFile = new ComponentFile(new File(componentRootPath + "/" + "GWA-Tracker.apk"));
    
            componentRepositoryInstance.save(binomial, binomialFile);
            componentRepositoryInstance.save(gallery, galleryFile);
            componentRepositoryInstance.save(imageUpload, imageUploadFile);
            componentRepositoryInstance.save(map, mapFile);
            componentRepositoryInstance.save(tracker, trackerFile);
            componentRepositoryInstance.save(joinus, joinusFile);
            
            return componentRepositoryInstance.listAll();
        }catch(Exception e){
            System.out.println("Erro no cadastro inicial dos componentes APK.");
            validator.add(new ValidationMessage("Erro na instalação dos componentes iniciais.", "Erro de Setup"));
            validator.onErrorUsePageOf(this).list(componentRepositoryInstance);
            
            return new ArrayList<Component>();
        }
	}
	
	@Get
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}")
	public List<Component> list(ComponentRepositoryInstance componentRepositoryInstance){
	    addIncludes(componentRepositoryInstance);
	    
	    List<Component> lc = componentRepositoryInstance.listAll();
	    
    	if(lc.size() == 0){
    	    lc = registerComponents(componentRepositoryInstance);
    	}
    	
    	return lc;
	}
	
	@Get
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}/new")
	public void form(ComponentRepositoryInstance componentRepositoryInstance){
	    addIncludes(componentRepositoryInstance);
		/*Go to new.jsp */
	}
	
	@Post
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}/new")
	//If you wan't to insert a new file programatically, use componentController.insert(repository, component, new ComponentFile(File)); 
	public void insert(ComponentRepositoryInstance componentRepositoryInstance, final Component component, final UploadedFile componentUploadedFile){
		addIncludes(componentRepositoryInstance);
		validateComponent(component);
		validateComponentFile(componentUploadedFile);
		validator.onErrorUse(Results.logic()).forwardTo(ComponentRepositoryController.class).form(componentRepositoryInstance);
		
		try {
			componentRepositoryInstance.save(component, componentUploadedFile);
		}catch(Exception e) {
			result.use(Results.status()).badRequest((String) null);
			return;
		}
		
		result.redirectTo(this).list(componentRepositoryInstance);
	}

	@Delete
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}/{component.id}")
	public void delete(ComponentRepositoryInstance componentRepositoryInstance, final Component component){
		File componentFile = new File(componentRepositoryInstance.getCollablet().getProperty("dirComponents") + "/" + componentRepositoryInstance.find(component).getMd5hash() + ".apk");
		componentFile.delete();
		componentRepositoryInstance.delete(component);
		
		result.redirectTo(this).list(componentRepositoryInstance);
	}
	
	@Get
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}/{component.id}/download")
	public Download download(ComponentRepositoryInstance componentRepositoryInstance, final Component component){
		Component componentComplete = componentRepositoryInstance.find(component.getId());
		File componentFile = new File(componentRepositoryInstance.getCollablet().getProperty("dirComponents") + "/" + componentComplete.getMd5hash() + ".apk");
		String componentFileName = componentComplete.getName() + "-" + componentComplete.getVersion() + ".apk";
        return new FileDownload(componentFile, "application/vnd.android.package-archive", componentFileName); 
	}
	
	@Get
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}/{component.md5hash}/downloadByMd5hash")
	public Download downloadByHash(ComponentRepositoryInstance componentRepositoryInstance, final Component component){
		return download(componentRepositoryInstance, componentRepositoryInstance.findByMd5hash(component.getMd5hash())); 
	}
}
