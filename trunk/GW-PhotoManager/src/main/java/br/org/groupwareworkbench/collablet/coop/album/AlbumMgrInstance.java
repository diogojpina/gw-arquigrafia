/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
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

import java.util.Date;
import java.util.List;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;

@ComponentInfo(
        version = "0.1",
        configurationURL = "/groupware-workbench/album/{albumMgr}",
        retrieveURL = "/groupware-workbench/album/{albumMgr}/{idAlbum}"
)
public class AlbumMgrInstance extends AbstractBusiness {

    public AlbumMgrInstance(Collablet collablet) {
        super(collablet);
    }

    public void save(Album album) {
        album.setCollablet(getCollablet());
        album.save();
    }

    public List<Album> listByUser(User user) {
        return Album.listByUser(user, getCollablet());
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
}

