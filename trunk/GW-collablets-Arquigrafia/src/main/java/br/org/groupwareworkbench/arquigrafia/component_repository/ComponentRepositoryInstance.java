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

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.org.groupwareworkbench.core.android.ComponentInstaller;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.android.Component;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;

@ComponentInfo(version = "0.1", 
        configurationURL = "/groupware-workbench/repository/{componentRepository}",
        retrieveURL = "/groupware-workbench/repository/{componentRepository}")
public class ComponentRepositoryInstance extends AbstractBusiness{

    public ComponentRepositoryInstance(Collablet collablet) {
        super(collablet);
    }
    
    public void save(Component component, UploadedFile uploadedFile) throws IOException, NoSuchAlgorithmException {
        ComponentInstaller.install(component, uploadedFile);
    }

    public void save(Component c) {
        c.save();
    }
    
    public void delete(Component c){
        c.delete();
    }
    
    public Component downloadByMd5hash(String md5hash){
       return Component.findByMd5hash(md5hash);
    }

    //Busca um componente completo a partir de um que só tem o id. Bem útil
    //nas requisições que recebem um objeto Component por get
    public Component find(Component c){
        return find(c.getId());
    }
    
    public Component find(long id){
        return Component.find(id);
    }
    
    public Component findByMd5hash(String md5hash){
        return Component.findByMd5hash(md5hash);
    }
    
    public List<Component> listAll() {
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Component> q = em.createQuery("FROM Component", Component.class);
        return q.getResultList();
    }
}
