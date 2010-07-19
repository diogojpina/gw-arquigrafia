package br.org.groupwareworkbench.arquigrafia.photo;

import java.awt.Dimension;
import java.awt.Point;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.util.Date;
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
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.GenericEntity;
import br.org.groupwareworkbench.core.framework.CollabElementInstance;
import br.org.groupwareworkbench.core.framework.CollabletInstance;
import br.org.groupwareworkbench.core.util.ImageUtils;

@RequestScoped
@Resource
public class PhotoController {

    public static final String MSG_MIN_3_LETRAS = "Você deve digitar no mínimo 3 letras.";
    public static final String MSG_NENHUM_CAMPO_PREENCHIDO = "Nenhum campo foi preenchido.";
    public static final String MSG_NOME_OBRIGATORIO = "O nome é obrigatório.";
    public static final String MSG_IMAGEM_OBRIGATORIA = "Uma imagem é obrigatória.";
    public static final String MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR = "Não foi possível redimensionar a imagem.";
    public static final String MSG_FALHA_NO_UPLOAD = "Falha ao fazer o upload da imagem.";
    public static final String MSG_ENTIDADE_INVALIDA = "Não é uma entidade válida.";

    private final Result result;
    private final HttpServletRequest request;
    private final Validator validator;

    public PhotoController(Result result, Validator validator, HttpServletRequest request) {
        this.result = result;
        this.validator = validator;
        this.request = request;
    }

    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/img-thumb/{nomeArquivoUnico}")
    public Download imgThumb(PhotoMgrInstance photoInstance, String nomeArquivoUnico) {
        File file = photoInstance.imgThumb(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/img-show/{nomeArquivoUnico}")
    public Download imgShow(PhotoMgrInstance photoInstance, String nomeArquivoUnico) {
        File file = photoInstance.imgShow(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/img-crop/{nomeArquivoUnico}")
    public Download imgCrop(PhotoMgrInstance photoInstance, String nomeArquivoUnico) {
        File file = photoInstance.imgCrop(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }
    
    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/img-original/{nomeArquivoUnico}")
    public Download imgOriginal(PhotoMgrInstance photoInstance, String nomeArquivoUnico) {
        File file = photoInstance.imgOriginal(nomeArquivoUnico);
        FileDownload fs = new FileDownload(file, "image/jpg", file.getName());
        return fs;
    }

    private void addIncludes(PhotoMgrInstance photoInstance) {
        result.include("photoInstance", photoInstance);
        for (CollabElementInstance collabComponentInstance : photoInstance.getCollabElementInstances()) {
            String nomeComponente = collabComponentInstance.getName();
            result.include(nomeComponente, collabComponentInstance);
            System.out.println("O componente elemento " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        //Adiciona os filhos.
        for (CollabletInstance collabletInstance : photoInstance.getSubordinatedInstances()) {
            String nomeComponente = collabletInstance.getComponentInstanceName();
            result.include(nomeComponente, collabletInstance);
            System.out.println("O componente filho" + collabletInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        for (CollabletInstance pai : photoInstance.getParentsInstances()) {
            String nomeComponente = pai.getComponentInstanceName();
            result.include(nomeComponente, pai);
            System.out.println("O componente antecessor " + pai.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }

    @Post
    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/show/{idPhoto}")
    public void show(PhotoMgrInstance photoInstance, long idPhoto) {
        result.include("idPhoto", idPhoto);
        result.include("nameCollablet","photo");
        Photo photo = photoInstance.buscaPhotoById(idPhoto);
        //addIncludes();
        result.include("photoTitle", photo.getNome());
        if (photo.getDescricao() != null && !photo.getDescricao().isEmpty()) {
            result.include("photoDescription", photo.getDescricao());
        }
        if (photo.getData() != null) {
            result.include("photoDate", DateFormat.getInstance().format(photo.getData()));
        }
        if (photo.getLugar() != null && !photo.getLugar().isEmpty()) {
            result.include("photoLocation", photo.getLugar());
        }
        addIncludes(photoInstance);
        photoInstance.processWidgets(request, photo);
        result.include("photo",photo);
        
    }

    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo")
    public void busca(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/{photoInstance}/photo/buscaTag/{tagName}")
    public void buscaFotoPorId(String tagName, List<GenericEntity> photos, PhotoMgrInstance photoInstance) {
        List<Photo> resultFotosBusca = photoInstance.buscaFotoPorListaId(photos);
        result.include("fotos", resultFotosBusca);
        result.include("thumbPrefix", photoInstance.getThumbPrefix());
        result.include("cropPrefix", photoInstance.getCropPrefix());
        result.include("mostraPrefix", photoInstance.getMostraPrefix());
        result.include("dirImagem", photoInstance.getDirImages());
        result.include("tagTerm", tagName);
        result.include("numResults", resultFotosBusca.size());

        addIncludes(photoInstance);

        result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/{photoInstance}/photo/busca")
    public void buscaFoto(String busca, PhotoMgrInstance photoInstance) {
        if (busca.length() < 3) {
            validator.add(new ValidationMessage(MSG_MIN_3_LETRAS, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFoto(busca);

        result.include("fotos", resultFotosBusca);
        result.include("thumbPrefix", photoInstance.getThumbPrefix());
        result.include("cropPrefix", photoInstance.getCropPrefix());
        result.include("mostraPrefix", photoInstance.getMostraPrefix());
        result.include("dirImagem", photoInstance.getDirImages());
        result.include("searchTerm", busca);
        result.include("numResults", resultFotosBusca.size());

        addIncludes(photoInstance);
        result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/{photoInstance}/photo/buscaA")
    public void buscaFotoAvancada(String nome, String descricao, String lugar, Date date, PhotoMgrInstance photoInstance) {
        if (nome.isEmpty() && descricao.isEmpty() && lugar.isEmpty() && date == null) {
            validator.add(new ValidationMessage(MSG_NENHUM_CAMPO_PREENCHIDO, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFotoAvancada(nome, lugar, descricao, date);
        result.include("fotos", resultFotosBusca);
        result.include("thumbPrefix", photoInstance.getThumbPrefix());
        result.include("cropPrefix", photoInstance.getCropPrefix());
        result.include("dirImagem", photoInstance.getDirImages());

        addIncludes(photoInstance);
        result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
    }

    @Get
    @Path(value = "/groupware-workbench/{photoInstance}/photo/registra")
    public void registra(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/{photoInstance}/photo/registra")
    public void save(Photo photoRegister, UploadedFile foto, PhotoMgrInstance photoInstance, User user) {

        // Validações:
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

        photoInstance.processWidgets(request, photoRegister);
        addIncludes(photoInstance);
        result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance);
    }

    @Delete
    @Path(value = "/groupware-workbench/{photoInstance}/photo/show/{idPhoto}")
    public void delete(PhotoMgrInstance photoInstance, long idPhoto) {
        if (idPhoto < 1) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        photoInstance.delete(idPhoto);
        addIncludes(photoInstance);
    }
}
