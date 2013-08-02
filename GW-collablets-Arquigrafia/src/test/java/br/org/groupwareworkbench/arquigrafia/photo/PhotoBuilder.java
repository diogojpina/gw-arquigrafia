package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.List;
import java.util.UUID;

import br.org.groupwareworkbench.core.framework.Collablet;

import com.google.common.collect.Lists;

public class PhotoBuilder {

    private List<Photo> photos = Lists.newArrayList();
    private Collablet collablet = new Collablet(UUID.randomUUID().toString());

    public PhotoBuilder create() {
        scenario();
        return this;
    }
    
    public void destroy() {
        for (Photo photo : photos) {
            photo.delete();
        }
    }
    
    private void scenario() {
//        if (collablet.getId() == null)
            collablet.save();

        addPhotoWith("AGUIAR, Andrea Augusta de", "São Paulo");
        addPhotoWith("Ruth Cuiá Troncarelli", "São Paulo");
        addPhotoWith("MELLO, Eduardo Augusto Kneese de", "João Pessoa");
        addPhotoWith("MELLO, Eduardo Augusto Kneese de", "João Pessoa");
        addPhotoWith("Eduardo Augusto Kneese de MELLO", "João Pessoa");
        addPhotoWith("Ruth Cuiá Troncarelli", "Sao");
    }

    public PhotoBuilder addPhotoWith(String imageAuthor, String city) {
        Photo photo = new Photo();
        photo.setImageAuthor(imageAuthor);
        photo.setCity(city);
        photo.setName(UUID.randomUUID().toString());
        photo.setNomeArquivo(UUID.randomUUID().toString());
        photo.setCollablet(collablet);
        photo.save();
        photos.add(photo);
        return this;
    }
    
    public Collablet getCollablet() {
        return collablet;
    }
    
    
    
}
