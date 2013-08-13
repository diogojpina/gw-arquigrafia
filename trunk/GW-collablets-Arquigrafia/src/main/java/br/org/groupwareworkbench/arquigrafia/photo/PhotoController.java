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
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.download.Download;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.validator.Validations;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.imports.PhotoImporter;
import br.org.groupwareworkbench.arquigrafia.imports.PhotoReviewImport;
import br.org.groupwareworkbench.arquigrafia.imports.PhotoUpdateImport;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;
import br.org.groupwareworkbench.core.routing.GroupwareInitController;
import br.org.groupwareworkbench.core.security.util.SecurityUtil;
import br.org.groupwareworkbench.core.util.Pagination;
import br.org.groupwareworkbench.core.util.WrapperEncoderParam;
import br.org.groupwareworkbench.core.util.debug.TimeLog;

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
    
    private static Random rnd = new Random();

    public PhotoController(Result result, Validator validator, WidgetInfo info, HttpSession session,
            RequestInfo requestInfo) {
        this.result = result;
        this.validator = validator;
        this.info = info;
        this.session = session;
        this.requestInfo = requestInfo;
    }

    @Get
    @Path(value = "/photo/{photoMgr}/index")
    public void index(PhotoMgrInstance photoMgr) {
        addIncludes(photoMgr);
    }

    @Get
    @Path(value = "/photo/{photoMgr}/upload")
    public void upload(PhotoMgrInstance photoMgr) {
        Photo p = new Photo();
        p.setCollablet(photoMgr.getCollablet());
        result.include("allowModificationsList", Photo.AllowModifications.values());
        result.include("allowCommercialUsesList", Photo.AllowCommercialUses.values());
        result.include("photo", p);

        addIncludes(photoMgr);
    }

    @Get
    @Path(value = "/photo/img-thumb/{idPhoto}")
    public Download imgThumb(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);

        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return null;
        }
        return photo.downloadImgThumb();

    }

    @Get
    @Path(value = {"/photo/img-show/{idPhoto}", "/photo/img-show/{idPhoto}.jpeg"})
    public Download imgShow(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return null;
        }
        return photo.downloadImgShow();
    }

    @Get
    @Path(value = "/photo/img-crop/{idPhoto}")
    public Download imgCrop(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return null;
        }
        return photo.downloadImgCrop();
    }

    @Get
    @Path(value = "/photo/img-original/{idPhoto}")
    public Download imgOriginal(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return null;
        }
        return photo.downloadImgOriginal();
    }

    // @Get
    // @Path(value = "/photo/delete/{idPhoto}")
    // public void imgDelete(long idPhoto) {
    // Photo photo = Photo.findById(idPhoto);
    // if (photo == null) {
    // result.notFound();
    // } else {
    // /* TODO review the design of the field users in Photo.
    // * Now we are getting an array of users, but we just
    // * need a single user. At follows we assume that there
    // * is always at least one user and that the first
    // * user is the photo's owner.
    // */
    //
    // if(SecurityUtil.checkOwnership(session, photo.getUsers().get(0).getLogin())) {
    // photo.setDeleted(true);
    // photo.save();
    // } else {
    // System.out.println("Someone tried to delete a photo that he does not own.");
    // }
    // result.redirectTo("/");
    // }
    // }

    private void addIncludes(PhotoMgrInstance photoMgr) {
        result.include(photoMgr.getCollablet().getName(), photoMgr);
        photoMgr.getCollablet().includeDependencies(result);
    }

    // FIXME: @Get e @Post ao mesmo tempo? Separar as duas coisas. Não é idempotente.
    @Post
    @Get
    @Path(value = {"/photo/{idPhoto}", "/photo/{idPhoto}.jpeg"})
    public void show(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        showById(photo);
    }

    @Get
    @Path(value = "/acervo/fauusp/{tombo}")
    public void showByTumbling(String tombo) {
        Photo photo = Photo.findByTombo(tombo);
        showById(photo);
    }

    private void showById(Photo photo) {
        TimeLog log = new TimeLog("CP");
        User user = (User) session.getAttribute("userLogin");

        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return;

        }

        User userPhoto = photo.getUsers().get(0);

        log.log("4");
        if (userPhoto.getId().compareTo(user.getId()) == 0) {

            result.include("usuarioCriador", "sim");
            log.log("5");
        }

        result.include("previousPhoto", Photo.previous(photo)).include("nextPhoto", Photo.next(photo));

        result.include("idPhoto", photo.getId());
        log.log("6");
        result.include("photo", photo);
        log.log("7");
        PhotoMgrInstance photoMgr = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        log.log("8");
        addIncludes(photoMgr);
        log.log("9");
        photoMgr.getCollablet().processWidgets(info, photo);
        log.log("10");
        result.use(Results.representation()).from(photo).serialize();
        log.log("11");
    }

    @Get
    @Path(value = "/photo/{idPhoto}/evaluate")
    public void evaluate(long idPhoto) {
        User user = (User) session.getAttribute("userLogin");
        Photo photo = Photo.findById(idPhoto);
        User userPhoto = photo.getUsers().get(0);

        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
        }
        if (userPhoto.getId().compareTo(user.getId()) == 0) {
            result.include("usuarioCriador", "sim");
        }

        result.include("idPhoto", idPhoto);
        result.include("photo", photo);
        PhotoMgrInstance photoMgr = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        addIncludes(photoMgr);
        photoMgr.getCollablet().processWidgets(info, photo);
        result.use(Results.representation()).from(photo).serialize();
    }

    @SuppressWarnings("unchecked")
    @Get
    @Path(value = "/photo/{photoMgr}/list")
    public void busca(PhotoMgrInstance photoMgr) {
        addIncludes(photoMgr);

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
            result.of(this).busca(photoMgr);
        }
    }

    @Post
    @Path(value = "/photo/{photoMgr}/buscaTag/{tagName}")
    public void buscaFotoPorId(String tagName, List<Object> photos, PhotoMgrInstance photoMgr) {
        List<Photo> resultFotosBusca = photoMgr.buscaFotoPorListaId(photos);

        result.use(Results.representation()).from(resultFotosBusca).serialize();
        result.include("fotos", resultFotosBusca);
        result.include("tagTerm", tagName);
        result.include("numResults", resultFotosBusca.size());

        addIncludes(photoMgr);

        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoMgr);
    }

    @Post
    @Path(value = "/photo/{photoMgr}/search")
    public void search(PhotoMgrInstance photoMgr, final String q, int page, int perPage) {

        validate(photoMgr, q);

        Pagination pagination = new Pagination(page, perPage);

        List<Tag> tags = Tag.searchByName(q, photoMgr.getCollablet().getDependency("tagMgr"));

        List<User> people = User.searchByName(q, new Collablet(8l, "userMgr"), pagination);

        Map<String, List<Photo>> photos = photoMgr.searchForAttributesOfThePhoto(q, pagination);

        result.include("tags", tags).include("people", people).include("photos", photos)
                .include("results", photoMgr.hasResults(photos)).include("searchTerm", q);
        addIncludes(photoMgr);
        result.use(logic()).forwardTo(PhotoController.class).busca(photoMgr);
    }

    private void validate(PhotoMgrInstance photoMgr, final String q) {
        validator.checking(new Validations() {
            {
                that(q.length() > 0, "length", "search.length");
            }
        });
        validator.onErrorForwardTo(this).busca(photoMgr);
    }

    @Get
    @Path("/photos/{photoMgr}/search/term")
    public void searchByAttribute(PhotoMgrInstance photoMgr, String term, String q, int page, int perPage) {
        List<Photo> results = photoMgr.searchForAttributeOfThePhoto(term, q, page, perPage);
        result.include("photos", results);
        addIncludes(photoMgr);
    }

    @Get
    @Path("/photos/{photoMgr}/show/search/term")
    public void showSearchByAttribute(PhotoMgrInstance photoMgr, String term, String q, int page, int perPage) {
        String search = WrapperEncoderParam.decode(q);
        List<Photo> results = photoMgr.searchForAttributeOfThePhoto(term, search, page, perPage);
        result.include("photos", results).include("term", term).include("searchTerm", search);
        addIncludes(photoMgr);
    }

    @Get
    @Path("/photos/{photoMgr}/counts/search/term")
    public void countsPhotosSearchByAttribute(PhotoMgrInstance photoMgr, String term) {
        String q = WrapperEncoderParam.decode(term);
        Map<String, Long> results = photoMgr.countsPhotosSearchByAttribute(q);
        result.use(Results.json()).withoutRoot().from(results).serialize();
    }

    @Get
    @Path("/photos/{photoMgr}/count/search/term")
    public void countPhotosSearchByAttribute(PhotoMgrInstance photoMgr, String term, String q) {
        String search = WrapperEncoderParam.decode(q);
        Long count = photoMgr.countPhotosSearchByAttribute(term, search);
        result.use(Results.json()).withoutRoot().from(count).serialize();
    }

    @Post
    @Path(value = "/photo/{photoMgr}/buscaA")
    public void buscaFotoAvancada(String nome, String descricao, String lugar, Date date, PhotoMgrInstance photoMgr) {
        if (nome.isEmpty() && descricao.isEmpty() && lugar.isEmpty() && date == null) {
            validator.add(new ValidationMessage(MSG_NENHUM_CAMPO_PREENCHIDO, "Erro"));
            validator.onErrorUse(Results.logic()).forwardTo(PhotoController.class).busca(photoMgr);
            return;
        }

        List<Photo> resultFotosBusca = photoMgr.buscaFotoAvancada(nome, lugar, descricao, date);
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

        addIncludes(photoMgr);
        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoMgr);
    }

    // TODO: Achar uma forma de fazer isto sem ter o photo na URL.
    @Get
    @Path(value = "/photo/{photoMgr}/registra")
    public void registra(PhotoMgrInstance photoMgr, Photo photo) {
        Photo newPhoto = photo;
        if (newPhoto == null) {
            newPhoto = new Photo();
        }
        newPhoto.setCollablet(photoMgr.getCollablet());
        newPhoto.setDataUpload(new Date());
        result.include("photoRegister", newPhoto);
        addIncludes(photoMgr);
    }

    @Post
    @Path(value = "/photo/{photoMgr}/registra")
    public void save(Photo photoRegister, UploadedFile foto, PhotoMgrInstance photoMgr) {

        System.out.println("nome => " + photoRegister.getName());
        System.out.println("AllowCommercialUses => " + photoRegister.getAllowCommercialUses());
        System.out.println("AllowModifications => " + photoRegister.getAllowModifications());
        System.out.println("cidade => " + photoRegister.getCity());
        System.out.println("estado => " + photoRegister.getState());
        System.out.println("pais => " + photoRegister.getCountry());
        System.out.println("bairro => " + photoRegister.getDistrict());
        System.out.println("autor obra => " + photoRegister.getWorkAuthor());
        System.out.println("autor imagem => " + photoRegister.getImageAuthor());
        System.out.println("data obra => " + photoRegister.getWorkdate());
        System.out.println("data de criacao da imagem => " + photoRegister.getDataCriacao());
        System.out.println("data de catalogacao => " + photoRegister.getCataloguingTime());
        System.out.println("rua => " + photoRegister.getStreet());
        System.out.println("descricao => " + photoRegister.getDescription());

        if (foto != null) System.out.println("file name => " + foto.getFileName());

        photoRegister.setNomeArquivo(foto == null ? null : foto.getFileName());
        result.include("photoRegister", photoRegister);

        if (foto == null) {
            validator.add(new ValidationMessage(MSG_IMAGEM_OBRIGATORIA, "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            // redirectTo(PhotoController.class).registra(photoMgr, photoRegister);
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
            photoMgr.save(photoRegister);
            photoRegister.saveImage(foto.getFile());
        } catch (RuntimeException e) {
            validator.add(new ValidationMessage(e.getMessage(), "Erro"));
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            // redirectTo(PhotoController.class).registra(photoMgr, photoRegister);
            return;
        }

        photoMgr.getCollablet().processWidgets(info, photoRegister);

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
            addIncludes(photoMgr);
            result.include("successMessage", MSG_SUCCESS);
            validator.add(new ValidationMessage("Imagem adicionada com sucesso.", "Upload finalizado"));
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            result.use(logic()).redirectTo(GroupwareInitController.class).init();
            // result.use(Results.logic()).redirectTo(PhotoController.class).registra(photoMgr, new Photo());
        }
    }

    @Get
    @Path(value = "/photo/{photoMgr}/edit/{idPhoto}")
    public void edit(PhotoMgrInstance photoMgr, final long idPhoto) {

        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return;
        }
        Collablet collablet = photo.getCollablet();
        result.include("photoRegister", photo)
            .include("userOwn", photo.getUsers().get(0))
            .include("photoMgr", photoMgr);
        collablet.includeDependencies(result);
        addIncludes(photoMgr);
        result.use(Results.representation()).from(photo).serialize();
    }

    @Put
    @Path(value = "/photo/{photoMgr}/update")
    public void update(Photo photoRegister, PhotoMgrInstance photoMgr, User userOwn) {
        Photo photo = Photo.findById(photoRegister.getId());

        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return;
        }

        User user = (User) session.getAttribute("userLogin");

        if (user != null) {
            photo.assignUser(userOwn);
            photo.assignUser(user);
        }

        attributesToUpdate(photoRegister, photo);

        photoMgr.update(photo);
        photoMgr.getCollablet().processWidgets(info, photo);
        addIncludes(photoMgr);
        result.include("successMessage", MSG_SUCCESS);
        result.use(Results.logic()).redirectTo(PhotoController.class).show(photo.getId());
    }

    // TODO: Verificar como serÃ¡ tratada as datas no ISO8601.
    private void attributesToUpdate(Photo photoRegister, Photo photo) {
        photo.setName(photoRegister.getName());
        photo.setImageAuthor(photoRegister.getImageAuthor());
        photo.setCity(photoRegister.getCity());
        photo.setState(photoRegister.getState());
        photo.setCountry(photoRegister.getCountry());
        photo.setDataCriacao(photoRegister.getDataCriacao());
        photo.setDistrict(photoRegister.getDistrict());
        photo.setWorkAuthor(photoRegister.getWorkAuthor());
        photo.setStreet(photoRegister.getStreet());
        photo.setWorkdate(photoRegister.getWorkdate());
        photo.setCataloguingTime(photoRegister.getCataloguingTime());
        // photo.setTombo(photoRegister.getTombo());
        photo.setAditionalImageComments(photoRegister.getAditionalImageComments());
        photo.setDescription(photoRegister.getDescription());
    }

    @Get
    @Post
    @Path(value = "/photo/delete/{idPhoto}")
    public void deletePhoto(long idPhoto) {

        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            this.photoNotFound(photo);
            return;
        }

        /*
         * TODO review the design of the field users in Photo. Now we are getting an array of users, but we just need a
         * single user. At follows we assume that there is always at least one user and that the first user is the
         * photo's owner.
         */

        if (SecurityUtil.checkOwnership(session, photo.getUsers().get(0).getLogin())) {
            photo.setDeleted(true);
            photo.save();
        } else {
            System.out.println("Someone tried to delete a photo that he does not own.");
        }
        result.redirectTo("/");

        // Previous implementation, that actually removed the Photos from the database.
        // Photo photo = Photo.findById(idPhoto);
        // if (photo == null) {
        // validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
        // return;
        // }
        // photo.delete();
        PhotoMgrInstance photoMgr = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        addIncludes(photoMgr);
    }

    @Get
    @Path(value = "/photo/{photoMgr}/registra_multiplos/{os}/{dir}")
    public void registraMultiplos(String os, String dir, PhotoMgrInstance photoMgr) {

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
                    photoMgr.save(imagem);
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
    @Path(value = "/photo/{idPhoto}")
    public void delete(long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        if (photo == null || photo.getDeleted()) {
            validator.add(new ValidationMessage(MSG_ENTIDADE_INVALIDA, "Erro"));
            return;
        }
        PhotoMgrInstance photoMgr = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
        photo.delete();
        addIncludes(photoMgr);
    }

    @Get
    @Path("/photo/{photoMgr}/listbypage/{pageSize}/{pageNumber}")
    public void listByPageAndOrder(PhotoMgrInstance photoMgr, int pageSize, int pageNumber) {
        List<Photo> photos = photoMgr.listPhotoByPageAndOrder(pageSize, pageNumber);

        if ("xml".equals(requestInfo.getRequest().getParameter("_format"))) {
            result.use(Results.representation()).from(photos).serialize();
        } else {
            result.use(Results.json()).from(photos).serialize();
        }
    }

    @Get
    @Path("/photo/{photoMgr}/listbyuserpage/{pageSize}/{pageNumber}")
    public void listByUserPageAndOrder(PhotoMgrInstance photoMgr, int pageSize, int pageNumber) {
        User user = (User) session.getAttribute("userLogin");
        List<Photo> photos = photoMgr.listPhotoByUserPageAndOrder(user, pageSize, pageNumber);
        result.use(Results.json()).from(photos).serialize();
    }

    @Get
    @Path("/photos/{photoMgr}/amount/{amount}")
    public void list(PhotoMgrInstance photoMgr, Integer amount) {
        List<Photo> photos = photoMgr.listRandomPhotos(amount);
        result.use(Results.json()).withoutRoot().from(photos).serialize();
    }
    
    @Get
    @Path("/photo/updateimportworkfau")
    public void updateImportWorkPhotosFau() {
        
        boolean reset = false;
        User user = null;
        try{
            System.out.println("Entrando UPDATE FAU: " + new Date());
            user = (User) session.getAttribute("userLogin");
            if (user != null && user.getLogin().equals("acervoreview")) {
                session.setMaxInactiveInterval(60*60*7); // necessario para manter a conexao quando houver um redirecionamento.
                    
                String userName = "acervofau";
                //String basePath = "C:\\imports\\acervofau";
                String basePath = "/work/imports/acervofau";
                reset = updatePhotosFor(userName, basePath);
            } else {
                System.out.println("nao eh usuario ACERVO FAU !!: "  + user.getLogin());
            }
        } catch (Exception e) {
            System.out.println("Erro ao captar usuario");
        }
        
        
        System.out.println("\nno reset update fau!! " + new Date() + "\n");
        validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
        result.use(logic()).redirectTo(GroupwareInitController.class).init();
    }
    
    @Get
    @Path("/photo/updateimportworkquapa")
    public void updateImportWorkPhotosQuapa() {
        
        boolean reset = false;
        User user = null;
        try{
            System.out.println("Entrando UPDATE Quapa: " + new Date());
            user = (User) session.getAttribute("userLogin");
            if (user != null && user.getLogin().equals("acervoreview")) {
                session.setMaxInactiveInterval(60*60*7); // necessario para manter a conexao quando houver um redirecionamento.
                    
                String userName = "acervoquapa";
                //basePath = "C:\\imports\\acervoquapa";
                String basePath = "/work/imports/acervoquapa";
                reset = updatePhotosFor(userName, basePath);
                
            } else {
                System.out.println("nao eh usuario ACERVO FAU !!: "  + user.getLogin());
            }
        } catch (Exception e) {
            System.out.println("Erro ao captar usuario");
        }
        
        
        System.out.println("\nno reset update quapa !! " + new Date() + "\n");
        validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
        result.use(logic()).redirectTo(GroupwareInitController.class).init();
    }
    
    private boolean updatePhotosFor(String userName, String basePath) {
        try {
            return new PhotoUpdateImport(userName, basePath).updateImportedImages();
        } catch (Exception e) {
            validator.add(new ValidationMessage("Erro ao atualizar imagens importadas do usuário:" + userName, "Erro na importação."));
            e.printStackTrace();
            return false;
        }
    }
    
    @Get
    @Path("/photo/reviewimportwork")
    public void reviewImportWorkPhotos() {
        
        boolean reset = false;
        User user = null;
        try{
            System.out.println("Entrando REVIEW: " + new Date());
            user = (User) session.getAttribute("userLogin");
            if (user != null && user.getLogin().equals("acervoreview")) {
                session.setMaxInactiveInterval(60*60*7); // necessario para manter a conexao quando houver um redirecionamento.
                    
                String userName = "acervofau";
                //String basePath = "C:\\imports\\acervofau";
                String basePath = "/work/imports/acervofau";
                reset = reviewPhotosFor(userName, basePath);
                //reset = rnd.nextBoolean();
                //System.out.println("WAIting...");
                //Thread.sleep(21000);
                if (! reset) {
                    userName = "acervoquapa";
                    //basePath = "C:\\imports\\acervoquapa";
                    basePath = "/work/imports/acervoquapa";
                    reset = reviewPhotosFor(userName, basePath);
                    //reset = rnd.nextBoolean();
                }
            } else {
                System.out.println("nao eh usuario ACERVO FAU !!: "  + user.getLogin());
            }
        } catch (Exception e) {
            System.out.println("Erro ao captar usuario");
        }
        
        
        if (reset) {
            User userNow = (User) session.getAttribute("userLogin");
            if (userNow != null)
                System.out.println("RESET NOW REDIR TO PHOTO IMPORT user: " + userNow.getLogin() + " " + new Date());
            else
                System.out.println("RESET NOW redir TO PHOTO IMPORT user now null " + new Date());
                
            if (user != null)
                session.setAttribute("userLogin", user);
            
            //validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            //result.forwardTo("/photo/import");
            result.redirectTo("/photo/reviewimportwork");
        } else {
            System.out.println("\nno reset !! " + new Date() + "\n");
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            result.use(logic()).redirectTo(GroupwareInitController.class).init();
        }
    }
    
    @Get
    @Path("/photo/reviewimport")
    public void reviewImportPhotos() {
        
        boolean reset = false;
        User user = null;
        try{
            System.out.println("Entrando REVIEW: " + new Date());
            user = (User) session.getAttribute("userLogin");
            if (user != null && user.getLogin().equals("acervoreview")) {
                session.setMaxInactiveInterval(60*60*7); // necessario para manter a conexao quando houver um redirecionamento.
                    
                String userName = "acervofau";
                //String basePath = "C:\\imports\\acervofau";
                String basePath = "/home/gw/imports/acervofau";
                reset = reviewPhotosFor(userName, basePath);
                //reset = rnd.nextBoolean();
                //System.out.println("WAIting...");
                //Thread.sleep(21000);
                if (! reset) {
                    userName = "acervoquapa";
                    //basePath = "C:\\imports\\acervoquapa";
                    basePath = "/home/gw/imports/acervoquapa";
                    reset = reviewPhotosFor(userName, basePath);
                    //reset = rnd.nextBoolean();
                }
            } else {
                System.out.println("nao eh usuario ACERVO FAU !!: "  + user.getLogin());
            }
        } catch (Exception e) {
            System.out.println("Erro ao captar usuario");
        }
        
        
        if (reset) {
            User userNow = (User) session.getAttribute("userLogin");
            if (userNow != null)
                System.out.println("RESET NOW REDIR TO PHOTO IMPORT user: " + userNow.getLogin() + " " + new Date());
            else
                System.out.println("RESET NOW redir TO PHOTO IMPORT user now null " + new Date());
                
            if (user != null)
                session.setAttribute("userLogin", user);
            
            //validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            //result.forwardTo("/photo/import");
            result.redirectTo("/photo/reviewimport");
        } else {
            System.out.println("\nno reset !! " + new Date() + "\n");
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            result.use(logic()).redirectTo(GroupwareInitController.class).init();
        }
    }
    
    private boolean reviewPhotosFor(String userName, String basePath) {
        try {
            return new PhotoReviewImport(userName, basePath).reviewImportedImages();
        } catch (Exception e) {
            validator.add(new ValidationMessage("Erro ao importar imagens do usuário:" + userName, "Erro na importação."));
            e.printStackTrace();
            return false;
        }
    }

    @Get
    @Path("/photo/import")
    public void importPhotos() {
        
        boolean reset = false;
        User user = null;
        try{
            System.out.println("Entrando IMPORT: " + new Date());
            user = (User) session.getAttribute("userLogin");
            if (user != null && user.getLogin().equals("acervoreview")) {
                session.setMaxInactiveInterval(60*60*7); // necessario para manter a conexao quando houver um redirecionamento.
                    
                String userName = "acervofau";
                //String basePath = "C:\\imports\\acervofau";
                //String basePath = "/home/gw/imports/acervofau";
                String basePath = "/work/imports/acervofau";
                reset = importPhotosFor(userName, basePath);
                //reset = rnd.nextBoolean();
                //System.out.println("WAIting...");
                //Thread.sleep(21000);
                if (! reset) {
                    userName = "acervoquapa";
                    //basePath = "C:\\imports\\acervoquapa";
                    //basePath = "/home/gw/imports/acervoquapa";
                    basePath = "/work/imports/acervoquapa";
                    reset = importPhotosFor(userName, basePath);
                    //reset = rnd.nextBoolean();
                }
            } else {
                System.out.println("nao eh usuario ACERVO FAU !!: "  + user.getLogin());
            }
        } catch (Exception e) {
            System.out.println("Erro ao captar usuario");
        }
        
        
        if (reset) {
            User userNow = (User) session.getAttribute("userLogin");
            if (userNow != null)
                System.out.println("RESET NOW REDIR TO PHOTO IMPORT user: " + userNow.getLogin() + " " + new Date());
            else
                System.out.println("RESET NOW redir TO PHOTO IMPORT user now null " + new Date());
                
            if (user != null)
                session.setAttribute("userLogin", user);
            
            //validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            //result.forwardTo("/photo/import");
            result.redirectTo("/photo/import");
        } else {
            System.out.println("\nno reset !! " + new Date() + "\n");
            validator.onErrorUse(Results.logic()).redirectTo(GroupwareInitController.class).init();
            result.use(logic()).redirectTo(GroupwareInitController.class).init();
        }
    }

    private boolean importPhotosFor(String userName, String basePath) {
        try {
            return new PhotoImporter(userName, basePath).buildImportImages();
        } catch (Exception e) {
            validator.add(new ValidationMessage("Erro ao importar imagens do usuário:" + userName, "Erro na importação."));
            e.printStackTrace();
            return false;
        }
    }

    private void photoNotFound(Photo photo) {

        if (photo != null) {
            PhotoMgrInstance photoMgr = (PhotoMgrInstance) photo.getCollablet().getBusinessObject();
            addIncludes(photoMgr);
        }

        result.notFound();
        return;
    }
    
    @Get
    @Path("/statistics")
    public void statistics() {
        Collablet photoMgr = Collablet.findByName("photoMgr");
        Collablet tagMgr = Collablet.findByName("tagMgr");
        Collablet commentMgr = Collablet.findByName("commentMgr");
        Collablet userMgr = Collablet.findByName("userMgr");
        Collablet binomialMgr = Collablet.findByName("binomialMgr");
        Collablet albumMgr = Collablet.findByName("albumMgr");
        Collablet arquigrafiaMgr = Collablet.findByName("arquigrafiaMgr");

        result.include("photoMgr", photoMgr);
        result.include("tagMgr", tagMgr);
        result.include("commentMgr", commentMgr);
        result.include("userMgr", userMgr);
        result.include("binomialMgr", binomialMgr);
        result.include("albumMgr", albumMgr);
        result.include("arquigrafiaMgr", arquigrafiaMgr);
    }
}
