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
import java.text.DateFormat;
import java.util.Collection;

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
    public static final String MSG_IMAGEM_OBRIGATORIA = "Uma imagem é obrigatória.";
    public static final String MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR = "Não foi possível redimensionar a imagem.";
    public static final String MSG_FALHA_NO_UPLOAD = "Falha ao fazer o upload da imagem.";
    public static final String MSG_ENTIDADE_INVALIDA = "Não é uma entidade válida.";

    private final WidgetInfo info;
    private final Validator validator;

    public AlbumMgrController(Result result, Validator validator, WidgetInfo info, HttpServletRequest request) {
        this.request = request;
        this.result = result;
        this.validator = validator;
        this.info = info;
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/list")
    public void list(final AlbumMgrInstance albumMgr) {
        User user = (User) request.getSession().getAttribute("userLogin");
        result.include("user", user);
        Collection<Album> albumList = albumMgr.listByUser(user);
        result.include("albumList", albumList);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(albumList).serialize();
    }

    @Get
    @Path(value = "/groupware-workbench/album/{id}/listPhotos")
    public void listPhotos(final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        AlbumMgrInstance albumMgr = (AlbumMgrInstance) album.getCollablet().getBusinessObject();
        Collection<Photo> photoList = album.getPhotos();
        result.include("photoList", photoList);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(photoList).serialize();
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/create")
    public void create(final AlbumMgrInstance albumMgr) {
        Album album = new Album();
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Get
    @Path(value = "/groupware-workbench/album/{id}")
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
    @Path(value = "/groupware-workbench/album/{albumMgr}/save/{idAlbum}")
    public void save(AlbumMgrInstance albumMgr, final long idAlbum) {
        Album album = Album.findById(idAlbum);
        albumMgr.save(album);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(albumMgr);
    }

    @Delete
    @Path(value = "/groupware-workbench/album/{id}")
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

    /* Photo's Management */

    @Post
    @Path(value = "/groupware-workbench/album/{albumMgr}/album/{idAlbum}/photo/registra/")
    public void save(AlbumMgrInstance albumMgr, final long idAlbum, Photo photoRegister, UploadedFile foto, User user) {
        PhotoMgrInstance photoInstance =
                (PhotoMgrInstance) albumMgr.getCollablet().getDependency("photoMgr").getBusinessObject();
        Album album = Album.findById(idAlbum);
        boolean erro = false;
        if (photoRegister.getNome().isEmpty()) {
            validator.add(new ValidationMessage(MSG_NOME_OBRIGATORIO, "Erro"));
            erro = true;
        }
        if (foto == null) {
            validator.add(new ValidationMessage(MSG_IMAGEM_OBRIGATORIA, "Erro"));
            erro = true;
        }
        if (erro) {
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
            return;
        }

        // Fim das validações.

        try {
            photoInstance.save(photoRegister);
            photoRegister.saveImage(foto.getFile());
        } catch (IOException e) {
            validator.add(new ValidationMessage(e.getMessage(), "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
            return;
        }

        photoInstance.getCollablet().processWidgets(info, photoRegister);
        addIncludes(photoInstance);
        photoRegister.save();
        album.add(photoRegister);
        // result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).registra(photoInstance);
    }// end

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/album/{idAlbum}/photo/registra")
    public void registra(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    private void addIncludes(PhotoMgrInstance photoInstance) {
        result.include("photoInstance", photoInstance);
        photoInstance.getCollablet().includeDependencies(result);
    }

    @Get
    @Path(value = "/groupware-workbench/album/{albumMgr}/photo/show/{idPhoto}")
    public void showPhoto(AlbumMgrInstance albumMgr, long idPhoto) {
        Photo photo = Photo.findById(idPhoto);

        PhotoMgrInstance photoInstance =
                (PhotoMgrInstance) albumMgr.getCollablet().getDependency("photoMgr").getBusinessObject();
        result.include("idPhoto", idPhoto);

        // addIncludes();
        result.include("photoTitle", photo.getNome());
        if (photo.getDescricao() != null && !photo.getDescricao().isEmpty()) {
            result.include("photoDescription", photo.getDescricao());
        }
        if (photo.getDataCriacao() != null) {
            result.include("photoDate", DateFormat.getInstance().format(photo.getDataCriacao()));
        }
        if (photo.getLugar() != null && !photo.getLugar().isEmpty()) {
            result.include("photoLocation", photo.getLugar());
        }
        addIncludes(photoInstance);
        photoInstance.getCollablet().processWidgets(info, photo);
        result.include("photo", photo);
        result.include("albumMgr", albumMgr);
    }

    @Delete
    @Path(value = "/groupware-workbench/album/{albumMgr}/album/{idAlbum}/remove/{idPhoto}")
    public void deletePhoto(final AlbumMgrInstance albumMgr, final long idAlbum, final long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        Album album = Album.findById(idAlbum);

        if (album == null || photo == null || photo == null) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        photo.delete();
        album.remove(photo);

        result.include("albumMgr", albumMgr);
        result.include("album", album);
        result.include("photo", photo);
        // addIncludes(photoInstance);
    }

    /*
     * @Post
     * @Path(value = "/groupware-workbench/album/{albumMgr}/album/{idAlbum}/show/{idPhoto}") public void addPhoto(final
     * AlbumMgrInstance albumMgr, final Long idAlbum, final Long idPhoto) { Photo photo = Photo.findById(idPhoto); Album
     * album = Album.findById(idAlbum); PhotoMgrInstance photoInstance = (PhotoMgrInstance)
     * albumMgr.getCollablet().getDependency("photoMgr").getBusinessObject(); if (album == null || photo == null ||
     * idPhoto < 1) { validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro")); return; }
     * photoInstance.save(Photo.findById(idPhoto));//nao adianta photo.save(); album.add(photo);
     * result.include("albumMgr", albumMgr); result.include("album", album); result.include("photo", photo);
     * //addIncludes(photoInstance); }
     */

}
