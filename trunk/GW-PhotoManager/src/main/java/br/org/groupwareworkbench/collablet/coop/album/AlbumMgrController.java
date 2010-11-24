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

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.MainCollablet;

@RequestScoped
@Resource
public class AlbumMgrController {
    private final Result result;
    private final HttpServletRequest request;

    public AlbumMgrController(Result result, HttpServletRequest request) {
        this.request = request;
        this.result = result;
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}")
    public void defaultPage(AlbumMgrInstance albumMgr) {
        addIncludes(albumMgr);
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/list/{idUser}")
    public void list(AlbumMgrInstance albumMgr, Long idUser) {
        User user = User.findById(idUser);
        List<Album> albunList = albumMgr.listByUser(user);
        result.include("albumList", albunList);
        result.use(Results.representation()).from(albunList).serialize();
        addIncludes(albumMgr);
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/listPhotos/{idAlbum}")
    public void listPhotos(AlbumMgrInstance albumMgr, Long idAlbum) {
        Album album = Album.findById(idAlbum);
        result.include("album", album);
        addIncludes(albumMgr);
    }

    @Get
    @Path({
        "/groupware-workbench/album/{albumMgr}/{idAlbum}",
        "/groupware-workbench/album/{albumMgr}/create"
    })
    public void retrieve(AlbumMgrInstance albumMgr, Long idAlbum) {
        Album album = Album.findById(idAlbum);
        result.include("album", album);
        addIncludes(albumMgr);
    }

    @Post
    @Path(value = "/groupware-workbench/album/{albumMgr}/save")
    public void save(AlbumMgrInstance albumMgr, Album album) {
        User user = (User) request.getSession().getAttribute("userLogin");
        album.setOwner(user);
        albumMgr.save(album);
        result.nothing();
    }

    @Post
    @Path(value = "/groupware-workbench/album/{albumMgr}/add/{idAlbum}/{idObject}")
    public void addToAlbum(AlbumMgrInstance albumMgr, Long idAlbum, Long idObject) {
        Photo photo = Photo.findById(idObject); //Por enquanto amarrado a Photo
        Album album = Album.findById(idAlbum);
        album.add(photo);
        album.save();
        addIncludes(albumMgr);
        result.nothing();
    }

    private void addIncludes(AlbumMgrInstance albumMgr) {
        result.include(albumMgr.getCollablet().getName(), albumMgr);
        albumMgr.getCollablet().includeDependencies(result);
        result.include(MainCollablet.getMainCollablet().getName(), MainCollablet.getMainCollablet().getBusinessObject());
        MainCollablet.getMainCollablet().includeDependencies(result);
    }
}
