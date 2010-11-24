package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
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
    
    public void save(Component component, UploadedFile uploadedFile) throws IOException, NoSuchAlgorithmException {
        File componentFile = null;
        File tmpComponentFile = null;

        try{
            long size = 0;
            tmpComponentFile = File.createTempFile("tempComponent", ".apk.tmp");
            
            //Read uploaded file to file system
            FileOutputStream componentFileOutputStream = new FileOutputStream(tmpComponentFile);
            byte[] tmpBytes = new byte[1024]; //buffer size. 1k is ok?
            int sizeRead;
            InputStream uploadedFileInputStream = uploadedFile.getFile();
            while((sizeRead = uploadedFileInputStream.read(tmpBytes)) > 0){
                size += sizeRead;
                componentFileOutputStream.write(tmpBytes, 0, sizeRead);
            }
            componentFileOutputStream.close();
            
            //Generating the md5 checksum from the file
            uploadedFileInputStream = uploadedFile.getFile();
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.reset();
            while((sizeRead = uploadedFileInputStream.read(tmpBytes)) > 0){
                md.update(tmpBytes, 0, sizeRead);
            }
            byte[] componentMD5 = md.digest();
            
            final String HEXES = "0123456789abcdef";
                
            final StringBuilder hex = new StringBuilder( 2 * componentMD5.length);
            for ( final byte b : componentMD5 ) {
                hex.append(HEXES.charAt((b & 0xF0) >> 4)).append(HEXES.charAt((b & 0x0F)));
            }

            String md5String = hex.toString();
            
            component.setMd5hash(md5String.substring(md5String.length()-32));
            //Setting the component date
            component.setInsertionDate(new Date());
            
            //Renaming the temporary component to the final name
            File componentFileDir = new File(getCollablet().getProperty("dirComponents"));
            componentFileDir.mkdirs();
            componentFile = new File(componentFileDir.getAbsolutePath() + "/" + component.getMd5hash() + ".apk");
            
            if(!tmpComponentFile.renameTo(componentFile)){
                throw new IOException("Erro ao mover arquivo do componente.");
            }
            //Setting the file size
            component.setSize(size);
        }catch(Exception e){
            if(tmpComponentFile != null){
                tmpComponentFile.delete();
            }
            if(componentFile != null){
                componentFile.delete();
            }
            throw new IOException("Erro na inserção do componente " + component.getName());
        }
        save(component);
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
