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
package br.org.groupwareworkbench.arquigrafia.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoController;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;
import br.org.groupwareworkbench.core.routing.Auth;

@RequestScoped
@Resource
public class ArquigrafiaController {

    public static final String MSG_MIN_3_LETRAS = "Você deve digitar no mínimo 3 letras.";
    
    private final Result result;
    private final WidgetInfo info;
    private final Validator validator;
    private final HttpSession session;
    private final RequestInfo requestInfo;
    private final HttpServletRequest request;

    public ArquigrafiaController(Result result, Validator validator, WidgetInfo info, HttpSession session,
            RequestInfo requestInfo, HttpServletRequest request) {
        this.result = result;
        this.validator = validator;
        this.info = info;
        this.session = session;
        this.requestInfo = requestInfo;
        this.request = request;
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/")
    public void index(ArquigrafiaMgrInstance arquigrafiaInstance) {
        if((request.getParameter("firstTime"))!=null) {
            result.include("firstTime", request.getParameter("firstTime"));
        }
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/project")
    public void project(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/projectMore")
    public void project_more(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }    

    @Get
    @Path(value = "/{arquigrafiaInstance}/termsOfService")
    public void terms_of_service(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/help")
    public void help(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/welcome")
    public void welcome(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/showMessage")
    public void showMessage(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);    
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/contact")
    public void contact(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    private void addIncludes(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include(arquigrafiaInstance.getCollablet().getName(), arquigrafiaInstance);
        arquigrafiaInstance.getCollablet().includeDependencies(result);
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/photo_avaliation/{idPhoto}")
    public void single_avaliation(ArquigrafiaMgrInstance arquigrafiaInstance, Long idPhoto) {
        Photo foto = Photo.findById(idPhoto);
        result.include("photo", foto);
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/photo_avaliation_avarage/{idPhoto}")
    public void avarage_avaliation(ArquigrafiaMgrInstance arquigrafiaInstance, Long idPhoto) {
        Photo foto = Photo.findById(idPhoto);
        result.include("photo", foto);
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Get
    @Path(value = "/{arquigrafiaInstance}/photo/{idPhoto}")
    public void single(ArquigrafiaMgrInstance arquigrafiaInstance, Long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        result.include("photo", photo);
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
    
    @Post
    @Path(value = "/photo/busca")
    public void doSearch(String busca, ArquigrafiaMgrInstance arquigrafiaInstance, PhotoMgrInstance photoMgr, TagMgrInstance tagInstance) {
        if (busca.length() < 3) {
            validator.add(new ValidationMessage(MSG_MIN_3_LETRAS, "Erro"));
            validator.onErrorUse(Results.logic()).forwardTo(ArquigrafiaController.class).searchResult(arquigrafiaInstance);
            return;
        }

        List<Photo> resultFotosBusca = photoMgr.buscaFoto(busca);

        Tag tag = Tag.findByName(busca, tagInstance.getCollablet());
        if (tag == null) {
            this.result.notFound();
            return;
        }

        result.include("tag", tag);

        Collablet tagCollablet = tag.getCollablet();
        TagMgrInstance tagMgr = (TagMgrInstance) tagCollablet.getBusinessObject();
        tagCollablet.includeDependencies(result);
        result.include("tagMgr", tagMgr);
        result.use(Results.representation()).from(tag).serialize();
        
        result.include("fotos", resultFotosBusca);
        result.include("searchTerm", busca);
        result.use(Results.logic()).forwardTo(PhotoController.class).busca(photoMgr);
    }
    
    @Get
    @Path(value = "/photo/{photoMgr}/list")
    public void searchResult(ArquigrafiaMgrInstance arquigrafiaInstance) {
        addIncludes(arquigrafiaInstance);
    }
}
