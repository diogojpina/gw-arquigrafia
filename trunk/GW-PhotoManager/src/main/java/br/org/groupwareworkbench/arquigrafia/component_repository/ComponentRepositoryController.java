package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.util.Date;
import java.util.List;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
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

	public ComponentRepositoryController(final Validator validator, final Result result){
		this.result = result;
		this.validator = validator;
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
	
	@Get
	@Path("/groupware-workbench/repository/{componentRepositoryInstance}")
	public List<Component> list(ComponentRepositoryInstance componentRepositoryInstance){
	    addIncludes(componentRepositoryInstance);
		return componentRepositoryInstance.listAll();
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
		long size = 0;
		
		validateComponent(component);
		validateComponentFile(componentUploadedFile);
		validator.onErrorUse(Results.logic()).forwardTo(ComponentRepositoryController.class).form(componentRepositoryInstance);
		
		File tmpComponentFile = null;
		File componentFile = null;
		File componentFileDir;
		try {
			tmpComponentFile = File.createTempFile("tempComponent", ".apk.tmp");
			//Read uploaded file to file system
			FileOutputStream componentFileOutputStream = new FileOutputStream(tmpComponentFile);
			InputStream uploadedFileInputStream = componentUploadedFile.getFile();
			byte[] tmpBytes = new byte[1024]; //buffer size. 1k is ok?
			int sizeRead;
			while((sizeRead = uploadedFileInputStream.read(tmpBytes)) > 0){
				size += sizeRead;
				componentFileOutputStream.write(tmpBytes, 0, sizeRead);
			}
			componentFileOutputStream.close();
			//Generating the md5 checksum from the file
			uploadedFileInputStream.reset();
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.reset();
			while((sizeRead = uploadedFileInputStream.read(tmpBytes)) > 0){
				md.update(tmpBytes, 0, sizeRead);
			}
			byte[] componentMD5 = md.digest();
			BigInteger md5BigInteger = new BigInteger(componentMD5);
			String md5String = md5BigInteger.toString(16);
			while(md5String.length() < 32){
				md5String = "0" + md5String;
			}
			component.setMd5hash(md5String.substring(md5String.length()-32));
			//Setting the component date
			component.setInsertionDate(new Date());
			
			//Renaming the temporary component to the final name
			componentFileDir = new File(componentRepositoryInstance.getCollablet().getProperty("dirComponents"));
			componentFileDir.mkdirs();
			componentFile = new File(componentFileDir.getAbsolutePath() + "/" + component.getMd5hash() + ".apk");
			
			if(!tmpComponentFile.renameTo(componentFile)){
				throw new IOException("Erro ao mover arquivo do componente.");
			}
			//Setting the file size
			component.setSize(size);
			//Inserting
			componentRepositoryInstance.save(component);
			
		}catch(Exception e) {
			if(tmpComponentFile != null){
				tmpComponentFile.delete();
			}
			if(componentFile != null){
				componentFile.delete();
			}
			result.use(Results.status()).badRequest((String) null);
			return;
		}

		addIncludes(componentRepositoryInstance);
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
