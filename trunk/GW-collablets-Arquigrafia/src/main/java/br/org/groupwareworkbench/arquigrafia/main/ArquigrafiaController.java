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
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;

@RequestScoped
@Resource
public class ArquigrafiaController {

    private final Result result;
    private final WidgetInfo info;
    private final Validator validator;
    private final HttpSession session;
    private final RequestInfo requestInfo;

    public ArquigrafiaController(Result result, Validator validator, WidgetInfo info, HttpSession session,
            RequestInfo requestInfo) {
        this.result = result;
        this.validator = validator;
        this.info = info;
        this.session = session;
        this.requestInfo = requestInfo;
    }

    @Get
    @Path(value = "/{arquigrafiaInstance}/")
    public void index(ArquigrafiaMgrInstance arquigrafiaInstance) {
        addIncludes(arquigrafiaInstance);
    }

    private void addIncludes(ArquigrafiaMgrInstance arquigrafiaInstance) {
        result.include("arquigrafiaInstance", arquigrafiaInstance);
        arquigrafiaInstance.getCollablet().includeDependencies(result);
    }
}
