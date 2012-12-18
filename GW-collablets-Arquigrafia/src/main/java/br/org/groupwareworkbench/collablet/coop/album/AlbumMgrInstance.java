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
package br.org.groupwareworkbench.collablet.coop.album;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;

@ComponentInfo(
        version = "0.1",
        configurationURL = "/album/{albumMgr}",
        retrieveURL = "/album/{albumMgr}/{idAlbum}"
)
public class AlbumMgrInstance extends AbstractBusiness {
    public static String albumCoverPath="/GW-Application-Arquigrafia/img/album_icon.png";

    public AlbumMgrInstance(Collablet collablet) {
        super(collablet);
    }

    public void save(Album album) {
        album.setCollablet(getCollablet());
        album.save();
    }

    private void createDefaultAlbum(User user) {
        Album album = new Album();
        album.setCreationDate(Calendar.getInstance().getTime());
        album.setOwner(user);
        album.setUrlCover(albumCoverPath);
        album.setTitle("Favoritos");
        album.setDescription("Meu album arquigrafia");
        this.save(album);
    }

    public List<Album> listByUser(User user) {
        List<Album> albuns = Album.listByUser(user, getCollablet());
        if(albuns.size() == 0) {
            createDefaultAlbum(user);
            albuns = Album.listByUser(user, getCollablet());
        }
        return albuns;
    }

    public List<Album> limitListByUser(User user) {
        return Album.limitListByUser(user, getCollablet());
    }

    public Album getAlbumByDefault(User user) {
        List<Album> albuns = this.listByUser(user);
        Album album;
        if (albuns == null || albuns.isEmpty()) { //it has no album
            album = new Album();
            album.setTitle("default");
            album.setCreationDate(new Date());
            album.setDescription("");
            album.setOwner(user);
        } else {
            album = albuns.get(0);
        }
        return album;
    }
    
    public void updateGenericReferencesOf(User user, List<Long> idAlbums, Long idObject) {
        Photo photo = Photo.findById(idObject); 
        List<Album> albums = Album.listByUser(user, getCollablet()); 

        if (idAlbums != null) {
            for (Long idAlbum : idAlbums) {
                Album album = Album.findById(idAlbum);
                update(album, photo);
                albums.remove(album);
            }
        }
        removeGenericReferences(albums, photo);
    }

    private void update(Album album, Photo photo) {
        if (!album.contains(photo)) {
            album.add(photo);
            album.update();
        }
    }

    public void removeGenericReferences(List<Album> albums, Photo photo) {
        for (Album album : albums) {
            if (album.contains(photo)) {
                album.remove(photo);
                album.update();
            }
        }
    }

    public void deleteGenericReference(Album album, Long idObject) {
        Photo photo = Photo.findById(idObject); 
        album.remove(photo);
        album.update();
    }
    
    
}
