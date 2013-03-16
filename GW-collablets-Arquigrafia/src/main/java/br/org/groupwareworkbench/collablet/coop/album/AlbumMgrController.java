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

import static br.com.caelum.vraptor.view.Results.logic;

import java.util.List;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.Validations;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoController;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.MainCollablet;

@RequestScoped
@Resource
public class AlbumMgrController {
    
    private final Result result;
    private final HttpServletRequest request;
    private final Validator validator;
    private final RequestInfo requestInfo;
    private ResourceBundle bundle;

    public AlbumMgrController(Result result, HttpServletRequest request, Validator validator, RequestInfo requestInfo) {
        this.request = request;
        this.result = result;
        this.validator = validator;
        this.requestInfo = requestInfo;
        this.bundle = ResourceBundle.getBundle("messages");
    }
    
    @Get
    @Path(value = "/album/{albumMgr}/list/{idUser}")
    public void list(AlbumMgrInstance albumMgr, Long idUser) {
        User user = User.findById(idUser);
        List<Album> albumList = albumMgr.listByUser(user);
        result.include("albumList", albumList);
        result.include("album", albumList.get(0));
        result.include("user", user);
        addIncludes(albumMgr);
        result.use(Results.representation()).from(albumList).serialize();
    }
    
    @Get
    @Path(value = "/album/{albumMgr}/list/{idUser}/{albumId}")
    public void list(AlbumMgrInstance albumMgr, Long idUser, Long albumId) {
        User user = User.findById(idUser);
        List<Album> albumList = albumMgr.listByUser(user);
        Album album = Album.findById(albumId);
        result.include("albumList", albumList);
        result.include("album", album);
        result.include("user", user);
        addIncludes(albumMgr);
        result.use(Results.representation()).from(albumList).serialize();
    }

    @Get
    @Path(value = "/album/{albumMgr}/default/{idAlbum}")
    public void listByAlbum(AlbumMgrInstance albumMgr, Long idAlbum) {
        final User user = (User) request.getSession().getAttribute("userLogin");
    }
    @Path(value = "/groupware-workbench/album/{albumMgr}/show/{idAlbum}/list/{idUser}")
    public void listByAlbum(AlbumMgrInstance albumMgr, Long idAlbum, Long idUser) {
        User user = User.findById(idUser);
        List<Album> albunList = albumMgr.listByUser(user);
        Album album = Album.findById(idAlbum);
        addIncludes(albumMgr);
        result.include("albumList", albunList)
        .include("album", album)
        .include("user", user)
        .forwardTo("/WEB-INF/jsp/albumMgr/list.jsp");
        result.use(Results.representation()).from(albunList).serialize();
    }
    
    
    @Get
    @Path(value = "/album/{albumMgr}/destroy/{idAlbum}")
    public void destroy(AlbumMgrInstance albumMgr, Long idAlbum) {
        final Album album = Album.findById(idAlbum);
        final User user = (User) request.getSession().getAttribute("userLogin");
        validator.checking(new Validations(){{
            that(album.getOwner().equals(user), "album", "album.is.not.user");
        }});
        validator.onErrorUse(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, user.getId());
        
        album.delete();
        result.use(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, user.getId());


    }
    
    @Get
    @Path(value = "/album/{albumMgr}/listPhotos/{idAlbum}")
    public void listPhotos(AlbumMgrInstance albumMgr, Long idAlbum) {
        Album album = Album.findById(idAlbum);
        result.include("album", album);
        addIncludes(albumMgr);
    }

    @Get
    @Path({
        "/album/{albumMgr}/{idAlbum}",
        "/album/{albumMgr}/create"
    })
    public void retrieve(AlbumMgrInstance albumMgr, Long idAlbum) {
        Album album = Album.findById(idAlbum);
        result.include("album", album);
        addIncludes(albumMgr);
    }

    @Get
    @Path("/album/{albumMgr}")
    public void newAlbum(AlbumMgrInstance albumMgr) {
        addIncludes(albumMgr);
    }

    @Get
    @Path("/album/new/{albumMgr}.json")
    public void newAddAlbum(AlbumMgrInstance albumMgr) {
        newAlbum(albumMgr);
        result.include("json", true).forwardTo("/WEB-INF/jsp/albumMgr/newAlbum.jsp");
    }
    
    @Post
    @Path(value = "/album/{albumMgr}/save")
    public void save(AlbumMgrInstance albumMgr, final Album album) {
        User user = (User) request.getSession().getAttribute("userLogin");

        respondWithValidation(albumMgr, album, user);
        
        album.setOwner(user);
        albumMgr.save(album);
        respondWith(albumMgr, user.getId());
    }

    public void respondWith(AlbumMgrInstance albumMgr, Long idUser) {

        if ("json".equals(requestInfo.getRequest().getParameter("_format"))) {
            result.use(Results.json()).withoutRoot().from(bundle.getString("user.registered")).serialize();
        } else {
            result.use(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, idUser);
        }
        
    }

    
    @Put
    @Path(value = "/album/{albumMgr}/save")
    public void update(AlbumMgrInstance albumMgr, Album album) {
        User user = (User) request.getSession().getAttribute("userLogin");
        respondWithValidation(albumMgr, album, user);
        Album albumFound = Album.findById(album.getId());
        albumFound.setTitle(album.getTitle());
        albumFound.setDescription(album.getDescription());
        albumMgr.save(albumFound);
        result.use(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, user.getId());
    }


    public void respondWithValidation(AlbumMgrInstance albumMgr, final Album album, User user) {

        if ("json".equals(requestInfo.getRequest().getParameter("_format"))) {
            validator.checking(new Validations() {{
                that(!album.getTitle().isEmpty(), "title", bundle.getString("album.title.not.empty"));
            }});
            validator.onErrorSendBadRequest();
        } else {
            validator.checking(new Validations() {{
                that(!album.getTitle().isEmpty(), "title", "album.title.not.empty");
            }});
            validator.onErrorUse(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, user.getId());
        }
        
    }

    
    @Get
    @Path("/album/{albumMgr}/edit/{idAlbum}")
    public void edit(AlbumMgrInstance albumMgr, Long idAlbum) {
        Album album = Album.findById(idAlbum);
        result.include("album", album);
        addIncludes(albumMgr);
    }
    
    @Get
    @Path(value = "/album/{albumMgr}/add/{photo.id}")
    public void addToAlbum(AlbumMgrInstance albumMgr, Photo photo) {
        result.include("photo", Photo.findById(photo.getId()));
        addIncludes(albumMgr);
    }

    @Post
    @Path(value = "/album/{albumMgr}/add/{idObject}")
    public void addToAlbum(AlbumMgrInstance albumMgr, List<Long> albums, Long idObject) {
        User user = (User) request.getSession().getAttribute("userLogin");
        albumMgr.updateGenericReferencesOf(user, albums, idObject);
        result.use(logic()).redirectTo(PhotoController.class).show(idObject);
    }

    @Get
    @Path(value = "/album/{idAlbum}/delete/{idObject}")
    public void deleteToAlbum(Long idAlbum, Long idObject) {
        User user = (User) request.getSession().getAttribute("userLogin");
        Album album = Album.findById(idAlbum);
        AlbumMgrInstance albumMgr = (AlbumMgrInstance) album.getCollablet().getBusinessObject();
        albumMgr.deleteGenericReference(album, idObject);
        
        result.use(logic()).redirectTo(AlbumMgrController.class).list(albumMgr, user.getId() , idAlbum);
        
    }

    private void addIncludes(AlbumMgrInstance albumMgr) {
        result.include(albumMgr.getCollablet().getName(), albumMgr);
        albumMgr.getCollablet().includeDependencies(result);
        result.include(MainCollablet.getMainCollablet().getName(), MainCollablet.getMainCollablet().getBusinessObject());
        MainCollablet.getMainCollablet().includeDependencies(result);
    }
}
