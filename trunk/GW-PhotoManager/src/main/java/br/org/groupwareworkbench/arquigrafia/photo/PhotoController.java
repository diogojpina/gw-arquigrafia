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
package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.IOException;

import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.List;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.WidgetInfo;

@RequestScoped
@Resource
public class PhotoController {

    public static final String MSG_MIN_3_LETRAS = "Você deve digitar no mínimo 3 letras.";
    public static final String MSG_NENHUM_CAMPO_PREENCHIDO = "Nenhum campo foi preenchido.";
    public static final String MSG_NOME_OBRIGATORIO = "O nome é obrigatório.";
    public static final String MSG_IMAGEM_OBRIGATORIA = "O arquivo deve ser informado.";
    public static final String MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR = "Não foi possível redimensionar a imagem.";
    public static final String MSG_FALHA_NO_UPLOAD = "Falha ao fazer o upload da imagem.";
    public static final String MSG_IMAGEM_INVALIDA = "O arquivo não foi reconhecido como uma imagem válida.";
    public static final String MSG_ENTIDADE_INVALIDA = "Não é uma entidade válida.";
    public static final String MSG_SUCCESS = "A foto foi salva com sucesso.";

    private final Result result;
    private final WidgetInfo info;
    private final Validator validator;

    public PhotoController(Result result, Validator validator, WidgetInfo info) {
        this.result = result;
        this.validator = validator;
        this.info = info;
    }

    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/index")
    public void index(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    @Get
    @Path(value = "/groupware-workbench/photo/img-thumb/{idPhoto}")
    public Download imgThumb(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgThumb();
    }

    @Get
    @Path(value = "/groupware-workbench/photo/img-show/{idPhoto}")
    public Download imgShow(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgShow();
    }

    @Get
    @Path(value = "/groupware-workbench/photo/img-crop/{idPhoto}")
    public Download imgCrop(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgCrop();
    }

    @Get
    @Path(value = "/groupware-workbench/photo/img-original/{idPhoto}")
    public Download imgOriginal(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgOriginal();
    }

    private void addIncludes(PhotoMgrInstance photoInstance) {
        result.include("photoInstance", photoInstance);
        photoInstance.getCollablet().includeDependencies(result);
    }

    // FIXME: @Get e @Post ao mesmo tempo? Separar as duas coisas. Não é idempotente.
    @Get
    @Post
    @Path(value = "/groupware-workbench/photo/{idPhoto}")
    public void show(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return;
        }

        result.include("idPhoto", idPhoto);
        result.include("photo", photo);
        PhotoMgrInstance photoInstance = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        addIncludes(photoInstance);
        photoInstance.getCollablet().processWidgets(info, photo);
        result.use(Results.representation()).from(photo).serialize();        
    }

    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/list")
    public void busca(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/buscaTag/{tagName}")
    public void buscaFotoPorId(String tagName, List<Object> photos, PhotoMgrInstance photoInstance) {
        List<Photo> resultFotosBusca = photoInstance.buscaFotoPorListaId(photos);

        result.use(Results.representation()).from(resultFotosBusca).serialize();
        result.include("fotos", resultFotosBusca);
        result.include("tagTerm", tagName);
        result.include("numResults", resultFotosBusca.size());

        addIncludes(photoInstance);

        result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/busca")
    public void buscaFoto(String busca, PhotoMgrInstance photoInstance) {
        if (busca.length() < 3) {
            validator.add(new ValidationMessage(MSG_MIN_3_LETRAS, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFoto(busca);
        
        result.include("fotos", resultFotosBusca);
        result.include("searchTerm", busca);

        addIncludes(photoInstance);
        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/buscaAlternativa")
    public void buscaFotoAlternativa(String busca, PhotoMgrInstance photoInstance) {
        if (busca.length() < 3) {
            validator.add(new ValidationMessage(MSG_MIN_3_LETRAS, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }
        List<Photo> resultFotosBusca = photoInstance.buscaFoto(busca);
        result.use(Results.representation()).from(resultFotosBusca).serialize();
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/buscaA")
    public void buscaFotoAvancada(String nome, String descricao, String lugar, Date date, PhotoMgrInstance photoInstance) {
        if (nome.isEmpty() && descricao.isEmpty() && lugar.isEmpty() && date == null) {
            validator.add(new ValidationMessage(MSG_NENHUM_CAMPO_PREENCHIDO, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFotoAvancada(nome, lugar, descricao, date);
        result.include("fotos", resultFotosBusca);

        StringBuilder term = new StringBuilder();
        if (!nome.isEmpty()) {
            term.append("Nome: \"").append(nome).append("\"");
        }
        if (!descricao.isEmpty()) {
            if (term.length() != 0) term.append(". ");
            term.append("Descrição: \"").append(descricao).append("\"");
        }
        if (!lugar.isEmpty()) {
            if (term.length() != 0) term.append(". ");
            term.append("Lugar: \"").append(lugar).append("\"");
        }
        if (date != null) {
            if (term.length() != 0) term.append(". ");
            term.append("Data: \"").append(new SimpleDateFormat("dd/MM/yyyy").format(date)).append("\"");
        }
        result.include("searchTerm", term.toString());

        addIncludes(photoInstance);
        result.use(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/buscaAvancadaAlternativa")
    public void buscaAvancadaAlternativa(String nome, String descricao, String lugar, Date date, PhotoMgrInstance photoInstance) {
        if (nome.isEmpty() && descricao.isEmpty() && lugar.isEmpty() && date == null) {
            validator.add(new ValidationMessage(MSG_NENHUM_CAMPO_PREENCHIDO, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFotoAvancada(nome, lugar, descricao, date);
        result.use(Results.representation()).from(resultFotosBusca).serialize();
    }

    // TODO: Achar uma forma de fazer isto sem ter o photo na URL.
    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/registra")
    public void registra(PhotoMgrInstance photoInstance, Photo photo) {
        if (photo == null) {
            photo = new Photo();
        }
        photo.setCollablet(photoInstance.getCollablet());
        result.include("photoRegister", photo);
        addIncludes(photoInstance);
    }

    // TODO: Pegar o usuário da sessão.
    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/registra")
    public void save(Photo photoRegister, UploadedFile foto, PhotoMgrInstance photoInstance, User user) {
        photoRegister.setNomeArquivo(foto == null ? null : foto.getFileName());
        result.include("photoRegister", photoRegister);

        boolean erro = false;
        if (foto == null) {
            validator.add(new ValidationMessage(MSG_IMAGEM_OBRIGATORIA, "Erro"));
            erro = true;
        }
        if (erro) {
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance, photoRegister);
            return;
        }

        if (user != null) {
            photoRegister.assignUser(user);
        }

        try {
            photoInstance.save(photoRegister);
            photoRegister.saveImage(foto.getFile());
        } catch (IOException e) {
            validator.add(new ValidationMessage(e.getMessage(), "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance, photoRegister);
            return;
        }

        photoInstance.getCollablet().processWidgets(info, photoRegister);
        addIncludes(photoInstance);
        result.include("successMessage", MSG_SUCCESS);
        result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance, new Photo());
    }

    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/registra_multiplos/{os}/{dir}")
    public void registraMultiplos(String os, String dir, PhotoMgrInstance photoInstance) {

        // TODO: Não deveria depender em saber qual é o sistema operacional.
        String pDir = dir.replace("|", "/");
        if (os.equals("windows")) {
            pDir = "C:/" + pDir;
        }

        File filesDir = new File(pDir);
        if (!filesDir.isDirectory()) return;

        int numFile = 1;
        File[] files = filesDir.listFiles();
        for (File file : files) {
            System.out.println("Enviando foto " + numFile + "/" + files.length);
            numFile++;
            String name = file.getName().substring(0, file.getName().length() - 4);
            String nomeArquivo = file.getName();

            try {
                InputStream input = null;
                try {
                    input = new FileInputStream(file);
                    Photo imagem = new Photo();
                    imagem.setNome(name);
                    imagem.setNomeArquivo(nomeArquivo);
                    photoInstance.save(imagem);
                    imagem.saveImage(input);
                } finally {
                    if (input != null) input.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @Delete
    @Path(value = "/groupware-workbench/photo/{idPhoto}")
    public void delete(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }

        PhotoMgrInstance photoInstance = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        photo.delete();
        addIncludes(photoInstance);
    }

    @Get
    @Path("/groupware-workbench/photo/{photoMgr}/listbypage/{pageSize}/{pageNumber}")
    public void listByPageAndOrder(PhotoMgrInstance photoMgr, int pageSize, int pageNumber) {
        List<Photo> photos = photoMgr.listPhotoByPageAndOrder(pageSize, pageNumber);
        result.use(Results.json()).from(photos).serialize();
    }
    
    // TODO: About de Arquigrafia.
    @Get
    @Path(value = "/groupware-workbench/photo/about")
    public void about(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }
}
