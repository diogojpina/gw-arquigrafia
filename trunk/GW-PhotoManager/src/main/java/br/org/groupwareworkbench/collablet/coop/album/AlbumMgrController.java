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

import java.io.IOException;
import java.io.Serializable;
import java.text.DateFormat;
import java.util.Collection;

import javax.persistence.Entity;
import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoController;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.WidgetInfo;

@RequestScoped
@Resource
public class AlbumMgrController {

    private final Result result;
    private final HttpServletRequest request;

    public static final String MSG_MIN_3_LETRAS = "Você deve digitar no mínimo 3 letras.";
    public static final String MSG_NENHUM_CAMPO_PREENCHIDO = "Nenhum campo foi preenchido.";
    public static final String MSG_NOME_OBRIGATORIO = "O nome é obrigatório.";
    public static final String MSG_Arquivo_OBRIGATORIA = "Um arquivo é obrigatória.";
    public static final String MSG_FALHA_NO_UPLOAD = "Falha ao fazer o upload da imagem.";
    public static final String MSG_ENTIDADE_INVALIDA = "Não é uma entidade válida.";
    public static final String MSG_SUCCESS_ADD = "O elemento foi adicionado";

    private final WidgetInfo info;
    private final Validator validator;

    public AlbumMgrController(Result result, Validator validator, WidgetInfo info, HttpServletRequest request) {
        this.request = request;
        this.result = result;
        this.validator = validator;
        this.info = info;
    }

    @Get
    @Path(value = "/groupware-workbench/albuns/{albumMgr}/list")
    public void list(final AlbumMgrInstance albumMgr) {
        User user = (User) request.getSession().getAttribute("userLogin");
        Collection<Album> albumList = albumMgr.listByUser(user);
        result.include("user", user);
        result.include("albumList", albumList);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(albumList).serialize();
    }

    @Get
    @Path(value = "/groupware-workbench/albuns/{id}/listObjects")
    public void listObjects(final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        AlbumMgrInstance albumMgr = (AlbumMgrInstance) album.getCollablet().getBusinessObject();
        Collection<Object> objectList = album.getObjects();
        result.include("objectList", objectList);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(objectList).serialize();
    }

    
    @Get
    @Path(value = "/groupware-workbench/albuns/{albumMgr}/create")
    public void create(final AlbumMgrInstance albumMgr) {
        Album album = new Album();
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Get
    @Path(value = "/groupware-workbench/albuns/{id}")
    public void retrieve(final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Post
    //@Path(value = "/groupware-workbench/albuns/{albumMgr}/save/{idAlbum}")
    @Path(value = "/groupware-workbench/albuns/{albumMgr}")
    public void save(AlbumMgrInstance albumMgr, final Album album) {
        result.include("album", album);
        result.include("albumMgr", albumMgr);
        albumMgr.save(album);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(albumMgr);
    }

    @Delete
    @Path(value = "/groupware-workbench/albuns/{id}")
    public void delete(final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        AlbumMgrInstance albumMgr = (AlbumMgrInstance) album.getCollablet().getBusinessObject();
        album.delete();
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(albumMgr);
    }

    /*
     * @Get
     * @Path(value="/groupware-workbench/album/{albumMgr}/resource/{resource*}") public File
     * getResource(AlbumMgrInstance albumMgr, String resource) { return albumMgr.resourcePath(resource); }
     */

    /* Object's Management */
    
    @Post
    @Path(value = "/groupware-workbench/albuns/{id}/object/")
    public void addObject(final long id, final Object object) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }
        album.add(object);
    }
    
    @Post
    @Get
    @Path(value = "/groupware-workbench/albuns/{albumMgr}/default/")
    public void addObjectAtDefaultAlbum( AlbumMgrInstance albumMgr,final String objectId, String strClass) {
        Object entity=null;
        try {
            Class classObject= Class.forName(strClass.trim());
            entity= albumMgr.findById(Long.decode(objectId.trim()),classObject);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        User user = (User) request.getSession().getAttribute("userLogin");
        
        Album album = albumMgr.getAlbumByDefault(user);
        
        if (album == null) {
            this.result.notFound();
            return;
        }
        album.add(entity);
        result.include("successAddObjectAtDefaultAlbum", MSG_SUCCESS_ADD);
        //result.include("album", album);
        //result.include("albumMgr", albumMgr);
    }
    
    @Delete
    @Path(value = "/groupware-workbench/albuns/{id}/object/}")
    public void removeObject(final long id, final Object object ) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        album.remove(object);
    }
}
