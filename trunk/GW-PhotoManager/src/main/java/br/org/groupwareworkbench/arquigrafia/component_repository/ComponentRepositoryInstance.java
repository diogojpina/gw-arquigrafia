package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;

@ComponentInfo(version = "0.1", 
        configurationURL = "/groupware-workbench/componentRepository/{componentRepository}",
        retrieveURL = "/groupware-workbench/componentRepository/{componentRepository}")
public class ComponentRepositoryInstance extends AbstractBusiness{

    public ComponentRepositoryInstance(Collablet collablet) {
        super(collablet);
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
