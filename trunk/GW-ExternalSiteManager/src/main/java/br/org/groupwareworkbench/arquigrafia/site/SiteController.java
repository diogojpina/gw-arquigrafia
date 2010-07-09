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
package br.org.groupwareworkbench.arquigrafia.site;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.org.groupwareworkbench.core.framework.CollabElementInstance;
import br.org.groupwareworkbench.core.framework.CollabletInstance;

@RequestScoped
@Resource
public class SiteController {

    private final Result result;

    public SiteController(Result result) {
        this.result = result;
    }

    @Get
    @Path(value="/groupware-workbench/{siteInstance}/site")
    public void index(SiteInstance siteInstance) {
        addIncludes(siteInstance);
    }

    private void addIncludes(SiteInstance siteInstance) {
        result.include("siteInstance", siteInstance);
        for (CollabElementInstance collabComponentInstance : siteInstance.getCollabElementInstances()) {
            String nomeComponente = collabComponentInstance.getName();
            result.include(nomeComponente, collabComponentInstance);
            System.out.println("O componente elemento " + collabComponentInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona os filhos.
        for (CollabletInstance collabletInstance : siteInstance.getSubordinatedInstances()) {
            String nomeComponente = collabletInstance.getComponentInstanceName();
            result.include(nomeComponente, collabletInstance);
            System.out.println("O componente filho" + collabletInstance.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona o antecessores.
        for (CollabletInstance pai : siteInstance.getParentsInstances()) {
            String nomeComponente = pai.getComponentInstanceName();
            result.include(nomeComponente, pai);
            System.out.println("O componente antecessor " + pai.getComponent().getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }
}
