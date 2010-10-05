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

import java.awt.Dimension;
import java.awt.Point;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.download.FileDownload;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoController;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;
import br.org.groupwareworkbench.core.util.ImageUtils;

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
        this.validator= validator;
        this.info = info;
    }
    
    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}")
    public void list(final Collablet collablet, final AlbumMgrInstance albumMgr) {
        User user = (User) request.getSession().getAttribute("userLogin");
        result.include("user", user);
        result.include("collablet", collablet);
        Collection<Album> albumList = albumMgr.listByUser(user);
        result.include("albumList", albumList);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(albumList).serialize();
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/{id}/listPhotos")
    public void listPhotos(final Collablet collablet, final AlbumMgrInstance albumMgr, final Long id) {
        //PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }
        result.include("collablet", collablet);
        Collection<Photo> photoList = album.getPhotos();
        result.include("photoList", photoList);
        //result.include("photoInstance", photoInstance);
        result.include("albumMgr", albumMgr);
        result.use(Results.representation()).from(photoList).serialize();
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/create")
    public void create(final Collablet collablet, final AlbumMgrInstance albumMgr) {
        Album album = new Album();
        result.include("collablet", collablet);
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/{id}")
    public void retrieve(final Collablet collablet, final AlbumMgrInstance albumMgr, final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        result.include("collablet", collablet);
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Post
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/save/{idAlbum}")
    public void save(final Collablet collablet, AlbumMgrInstance albumMgr, final Long idAlbum) {
        Album album = Album.findById(idAlbum);
        albumMgr.save(album);
        result.include("collablet", collablet);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(collablet, albumMgr);
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/remove/{id}")
    public void delete(Collablet collablet, AlbumMgrInstance albumMgr, final long id) {
        Album album = Album.findById(id);
        if (album != null) album.delete();
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(collablet, albumMgr);
    }

    /*@Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/resource/{resource*}")
    public File getResource(AlbumMgrInstance albumMgr, String resource) {
        return albumMgr.resourcePath(resource);
    }*/
    
    
    /*Photo's Management*/
    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/photo/img-thumb/{nomeArquivoUnico}")
    public Download imgThumb(Collablet collablet, AlbumMgrInstance albumMgr, String nomeArquivoUnico) {
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        File file = photoInstance.imgThumb(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/photo/img-show/{nomeArquivoUnico}")
    public Download imgShow(Collablet collablet, AlbumMgrInstance albumMgr, String nomeArquivoUnico) {
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        File file = photoInstance.imgShow(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }
    
    
    @Post
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/album/{idAlbum}/photo/registra/")
    public void save(Collablet collablet, AlbumMgrInstance albumMgr,final Long idAlbum, Photo photoRegister, UploadedFile foto, User user) {
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
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
           //validator.onErrorUse(Results.page()).redirect("/groupware-workbench/"+idCollabletInstance+"/photo/registra");
           validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
           return;
        }

        // Fim das validações.

        String nomeArquivo = foto.getFileName();
        photoRegister.setNomeArquivo(nomeArquivo);
        InputStream imagemOriginal = null;
        InputStream imagemThumb = null;
        InputStream imagemCropped = null;
        InputStream imagemMostra = null;

        try {
            byte[] rawphoto = new byte[foto.getFile().available()];
            foto.getFile().read(rawphoto); 
            imagemOriginal = new ByteArrayInputStream(rawphoto);
            imagemMostra = ImageUtils.createThumbnailIfNecessary(800, imagemOriginal, true);
            imagemOriginal.reset();
            imagemThumb = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, true);
            imagemOriginal.reset();
            InputStream imagemThumb2 = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, false);
            imagemThumb2.reset();
            Point cropPoint = ImageUtils.calcSqrThumbCropPoint(imagemThumb2);
            imagemThumb2.reset();
            imagemCropped = ImageUtils.cropImage(cropPoint, new Dimension(100, 100), imagemThumb2);
        } catch (IOException e) {
            validator.add(new ValidationMessage(MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
            return;
        }

        try {
            GregorianCalendar calendar = new GregorianCalendar();
            photoRegister.setDataCriacao(calendar.getTime());
            photoInstance.save(photoRegister);
            if (user != null) {
                photoInstance.assignToUser(photoRegister, user);
            }
            nomeArquivo = photoRegister.getNomeArquivoUnico(); // Para ter um só nome do arquivo.
            photoInstance.saveImage(imagemOriginal, nomeArquivo);  
            photoInstance.saveImage(imagemCropped, photoInstance.getCropPrefix() + nomeArquivo);
            photoInstance.saveImage(imagemThumb, photoInstance.getThumbPrefix() + nomeArquivo);
            photoInstance.saveImage(imagemMostra, photoInstance.getMostraPrefix() + nomeArquivo);
            result.include("originalImage", photoInstance.imgOriginal(nomeArquivo));
            result.include("croppedImage", photoInstance.imgCrop(nomeArquivo));
            result.include("thumbImage", photoInstance.imgThumb(nomeArquivo));
            result.include("showImage", photoInstance.imgShow(nomeArquivo));
        } catch (IOException e) {
            validator.add(new ValidationMessage(MSG_FALHA_NO_UPLOAD, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
            return;
        }

        photoInstance.getCollablet().processWidgets(info, photoRegister);
        addIncludes(photoInstance);
        photoRegister.save();
        album.add(photoRegister);
        //result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).registra(photoInstance);
    }//end
    
    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/album/{idAlbum}/photo/registra")
    public void registra(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }




    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/photo/img-crop/{nomeArquivoUnico}")
    public Download imgCrop(Collablet collablet, AlbumMgrInstance albumMgr, String nomeArquivoUnico) {
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        File file = photoInstance.imgCrop(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/photo/img-original/{nomeArquivoUnico}")
    public Download imgOriginal(Collablet collablet, AlbumMgrInstance albumMgr, String nomeArquivoUnico) {
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        File file = photoInstance.imgOriginal(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    private void addIncludes(PhotoMgrInstance photoInstance) {
        result.include("photoInstance", photoInstance);
        photoInstance.getCollablet().includeDependencies(result);

        //Adiciona os filhos.
        for (Collablet collabletInstance : photoInstance.getCollablet().getSubordinateds()) {
            String nomeComponente = collabletInstance.getName();
            result.include(nomeComponente, collabletInstance.getBusinessObject());
            System.out.println("O componente filho " + collabletInstance.getName() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        for (Collablet pai : photoInstance.getCollablet().getBottomUpHierarchy()) {
            String nomeComponente = pai.getName();
            result.include(nomeComponente, pai);
            System.out.println("O componente antecessor " + pai.getName() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }

    @Post
    @Get
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/photo/show/{idPhoto}")
    public void showPhoto(Collablet collablet, AlbumMgrInstance albumMgr, long idPhoto) {
        Photo photo = Photo.findById(idPhoto);

        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
        result.include("idPhoto", idPhoto);
        result.include("nameCollablet", "photo");
        //addIncludes();
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
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/album/{idAlbum}/remove/{idPhoto}")
    public void deletePhoto(final Collablet collablet, final AlbumMgrInstance albumMgr, final Long idAlbum, final Long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        Album album = Album.findById(idAlbum);
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
                
        if (album ==null || photo==null || idPhoto < 1) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        photo.delete();
        album.remove(photo);
        photoInstance.delete(Photo.findById(idPhoto));
        result.include("albumMgr", albumMgr);
        result.include("album", album);
        result.include("photo", photo);
        //addIncludes(photoInstance);
    }

    /*@Post
    @Path(value = "/groupware-workbench/{collablet}/albumMgr/{albumMgr}/album/{idAlbum}/show/{idPhoto}")
    public void addPhoto(final Collablet collablet, final AlbumMgrInstance albumMgr, final Long idAlbum, final Long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        Album album = Album.findById(idAlbum);
        PhotoMgrInstance photoInstance = (PhotoMgrInstance)collablet.getDependency("photoMgr").getBusinessObject();
                
        if (album ==null || photo==null || idPhoto < 1) {
         validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        
        photoInstance.save(Photo.findById(idPhoto));//nao adianta
        photo.save();
        album.add(photo);
        result.include("albumMgr", albumMgr);
        result.include("album", album);
        result.include("photo", photo);
        //addIncludes(photoInstance);
    }*/

}
