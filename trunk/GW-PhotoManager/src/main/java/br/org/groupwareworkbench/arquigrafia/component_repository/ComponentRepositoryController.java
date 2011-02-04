/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
*    This project was/is sponsored by RNP and FAPESP.
*
*    This file is part of Groupware Workbench (http://www.groupwareworkbench.org.br).
*
*    Groupware Workbench is free software: you can redistribute it and/or modify
*    it under the terms of the GNU Lesser General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    Groupware Workbench is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU Lesser General Public License for more details.
*
*    You should have received a copy of the GNU Lesser General Public License
*    along with Swift.  If not, see <http://www.gnu.org/licenses/>.
*/
package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import br.org.groupwareworkbench.core.framework.MainCollablet;
import br.org.groupwareworkbench.core.framework.android.Component;

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
	
    private void addIncludes(ComponentRepositoryInstance componentRepositoryInstance){
	    result.include(componentRepositoryInstance.getCollablet().getName(), componentRepositoryInstance);
	    componentRepositoryInstance.getCollablet().includeDependencies(result);
	    result.include(MainCollablet.getMainCollablet().getName(), MainCollablet.getMainCollablet().getBusinessObject());
        MainCollablet.getMainCollablet().includeDependencies(result);
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
