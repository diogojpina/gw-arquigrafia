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
package br.org.groupwareworkbench.arquigrafia.photo;

import static br.com.caelum.vraptor.view.Results.logic;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
//import br.org.groupwareworkbench.collablet.coord.counter.Observer;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.UserMgrInstance;
import br.org.groupwareworkbench.collablet.faq.Faq;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;
import br.org.groupwareworkbench.core.routing.GroupwareInitController;

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
    public static final String MSG_SUCCESS =
            "A foto foi salva com sucesso. Envie outra foto ou clique em fechar para voltar à pagina inicial.";

    private final Result result;
    private final WidgetInfo info;
    private final Validator validator;
    private final HttpSession session;
    private final RequestInfo requestInfo;

    public PhotoController(Result result, Validator validator, WidgetInfo info, HttpSession session,
            RequestInfo requestInfo) {
        this.result = result;
        this.validator = validator;
        this.info = info;
        this.session = session;
        this.requestInfo = requestInfo;
    }

    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/index")
    public void index(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);
    }

    @Get
    @Path(value = "/{photoInstance}/upload")
    public void upload(PhotoMgrInstance photoInstance) {
        Photo p = new Photo();
        p.setCollablet(photoInstance.getCollablet());
        result.include("photo", p);
        
        addIncludes(photoInstance);
    }
    
    @Get
    @Path(value = "/photo/img-thumb/{idPhoto}")
    public Download imgThumb(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgThumb();
    }

    @Get
    @Path(value = "/photo/img-show/{idPhoto}")
    public Download imgShow(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgShow();
    }

    @Get
    @Path(value = "/photo/img-crop/{idPhoto}")
    public Download imgCrop(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return null;
        }
        return photo.downloadImgCrop();
    }

    @Get
    @Path(value = "/photo/img-original/{idPhoto}")
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
        User user = (User) session.getAttribute("userLogin");
        Photo photo = Photo.findById(idPhoto);
        User userPhoto = photo.getUsers().get(0);
        
        if (photo == null) {
            result.notFound();
            return;
        }
        if (userPhoto.getId().compareTo(user.getId()) == 0){
            result.include("usuarioCriador", "sim");
        } 
            
        result.include("idPhoto", idPhoto);
        result.include("photo", photo);
        PhotoMgrInstance photoInstance = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        addIncludes(photoInstance);
        photoInstance.getCollablet().processWidgets(info, photo);
        result.use(Results.representation()).from(photo).serialize();
    }

    @SuppressWarnings("unchecked")
    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/list")
    public void busca(PhotoMgrInstance photoInstance) {
        addIncludes(photoInstance);

        // FIXME: adicionar a condição do header accepts-content
        // Melhor seria achar um jeito do vRaptor reportar esse estado, ao invés da aplicação refazer essa checagem
        boolean xmlRequest;
        try {
            xmlRequest = "xml".equals(requestInfo.getRequest().getParameter("_format"));
        } catch (Exception e) {
            xmlRequest = false;
        }

        if (xmlRequest) {
            result.use(Results.representation()).from((List<Photo>) result.included().get("fotos")).serialize();
        } else {
            result.of(this).busca(photoInstance);
        }
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

        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/busca")
    public void buscaFoto(String busca, PhotoMgrInstance photoInstance) {
        if (busca.length() < 3) {
            validator.add(new ValidationMessage(MSG_MIN_3_LETRAS, "Erro"));
            validator.onErrorUse(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoInstance.buscaFoto(busca);

        result.include("fotos", resultFotosBusca);
        result.include("searchTerm", busca);

        addIncludes(photoInstance);
        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/buscaA")
    public void buscaFotoAvancada(String nome, String descricao, String lugar, Date date, PhotoMgrInstance photoInstance) {
        if (nome.isEmpty() && descricao.isEmpty() && lugar.isEmpty() && date == null) {
            validator.add(new ValidationMessage(MSG_NENHUM_CAMPO_PREENCHIDO, "Erro"));
            validator.onErrorUse(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
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
        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoInstance);
    }

    // TODO: Achar uma forma de fazer isto sem ter o photo na URL.
    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/registra")
    public void registra(PhotoMgrInstance photoInstance, Photo photo) {
        Photo newPhoto = photo;
        if (newPhoto == null) {
            newPhoto = new Photo();
        }
        newPhoto.setCollablet(photoInstance.getCollablet());
        newPhoto.setDataUpload(new Date());
        result.include("photoRegister", newPhoto);
        addIncludes(photoInstance);
    }

    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/registra")
    public void save(Photo photoRegister, UploadedFile foto, PhotoMgrInstance photoInstance) {
        
        System.out.println("nome => " + photoRegister.getName());
        System.out.println("direitosAutorais => " + photoRegister.getCopyRights());
        System.out.println("cidade => " + photoRegister.getCity());
        System.out.println("estado => " + photoRegister.getState());
        System.out.println("pais => " + photoRegister.getCountry());
        System.out.println("bairro => " + photoRegister.getDistrict());
        System.out.println("autor obra => " + photoRegister.getWorkAuthor());
        System.out.println("data obra => " + photoRegister.getWorkdate());
        System.out.println("rua => " + photoRegister.getStreet());
        System.out.println("descricao => " + photoRegister.getDescription());

        if(foto!=null)
            System.out.println("file name => " + foto.getFileName());
        
        photoRegister.setNomeArquivo(foto == null ? null : foto.getFileName());
        result.include("photoRegister", photoRegister);

        if (foto == null) {
            validator.add(new ValidationMessage(MSG_IMAGEM_OBRIGATORIA, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class)
                    .registra(photoInstance, photoRegister);
            return;
        }

        User user = null;
        try {
            user = (User) session.getAttribute("userLogin");
        } catch (Exception e) {
        }

        if (user != null) {
            photoRegister.assignUser(user);
        }

        try {
            photoInstance.save(photoRegister);
            photoRegister.saveImage(foto.getFile());
        } catch (RuntimeException e) {
            validator.add(new ValidationMessage(e.getMessage(), "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class)
                    .registra(photoInstance, photoRegister);
            return;
        }

        photoInstance.getCollablet().processWidgets(info, photoRegister);

        // FIXME: adicionar a condição do header accepts-content
        // Melhor seria achar um jeito do vRaptor reportar esse estado, ao invés da aplicação refazer essa checagem
        boolean xmlRequest;
        try {
            xmlRequest = "xml".equals(requestInfo.getRequest().getParameter("_format"));
        } catch (Exception e) {
            xmlRequest = false;
        }

        if (xmlRequest) {
            result.use(Results.representation()).from(photoRegister).serialize();
        } else {
            addIncludes(photoInstance);
            result.include("successMessage", MSG_SUCCESS);
            result.use(logic()).redirectTo(GroupwareInitController.class).init();
            //result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoInstance, new Photo());
        }
    }

    @Get
    @Path(value = "/groupware-workbench/photo/{photoInstance}/edit/{idPhoto}")
    public void edit(PhotoMgrInstance photoInstance, final long idPhoto) {
        
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            result.notFound();
            return;
        }
        Collablet collablet = photo.getCollablet();
        result.include("photoRegister", photo);
        result.include("userOwn", photo.getUsers().get(0));
        result.include("photoMgr", photoInstance);
        collablet.includeDependencies(result);
        addIncludes(photoInstance);
        result.use(Results.representation()).from(photo).serialize();
    }
    
    @Post
    @Path(value = "/groupware-workbench/photo/{photoInstance}/update")
    public void update(Photo photoRegister, PhotoMgrInstance photoInstance, User userOwn) {
        User user = null;
        try {
            user = (User) session.getAttribute("userLogin");
        } catch (Exception e) {
        }
                
        if (user != null) {
            photoRegister.assignUser(userOwn);
            photoRegister.assignUser(user);
        }
        
        try {
            photoInstance.save(photoRegister);
        } catch (RuntimeException e) {
            validator.add(new ValidationMessage(e.getMessage(), "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(PhotoController.class)
                    .registra(photoInstance, photoRegister);
            return;
        }
        photoInstance.getCollablet().processWidgets(info, photoRegister);
        addIncludes(photoInstance);
        result.include("successMessage", MSG_SUCCESS);
        result.use(Results.logic()).redirectTo(PhotoController.class).show(photoRegister.getId());
    }
    
    @Post
    @Path(value = "/groupware-workbench/photo/delete/{idPhoto}")
    public void deletePhoto(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        photo.delete();
        PhotoMgrInstance photoInstance = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        addIncludes(photoInstance);
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
                    imagem.setName(name);
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

        if ("xml".equals(requestInfo.getRequest().getParameter("_format"))) {
            result.use(Results.representation()).from(photos).serialize();
        } else {
            result.use(Results.json()).from(photos).serialize();
        }
    }

    @Get
    @Path("/groupware-workbench/photo/{photoMgr}/listbyuserpage/{pageSize}/{pageNumber}")
    public void listByUserPageAndOrder(PhotoMgrInstance photoMgr, int pageSize, int pageNumber) {
        User user = (User) session.getAttribute("userLogin");
        List<Photo> photos = photoMgr.listPhotoByUserPageAndOrder(user, pageSize, pageNumber);
        result.use(Results.json()).from(photos).serialize();
    }
}
