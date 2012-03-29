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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.WidgetInfo;

@RequestScoped
@Resource
public class ArquigrafiaController {

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
        if("0".equals(request.getParameter("firstTime"))) {
            result.include("firstTime", 0);
        } else {
            if (((User) session.getAttribute("userLogin")).getId() == 2L) {
                result.include("firstTime", 1);
            }
        }
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/index")
    public void index2(ArquigrafiaMgrInstance arquigrafiaInstance) {
        if("no".equals(request.getParameter("firstTime"))) {
            result.include("firstTime", 0);
        } else {
            result.include("firstTime", 1);
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
        result.include("arquigrafiaMgr", arquigrafiaInstance);
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
    @Path(value = "/{arquigrafiaInstance}/photo/{idPhoto}")
    public void single(ArquigrafiaMgrInstance arquigrafiaInstance, Long idPhoto) {
        Photo photo = Photo.findById(idPhoto);
        result.include("photo", photo);
        result.include("arquigrafiaMgr", arquigrafiaInstance);
        addIncludes(arquigrafiaInstance);
    }
}
