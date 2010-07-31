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
import br.org.groupwareworkbench.core.framework.Collablet;

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
        for (Collablet collabComponentInstance : siteInstance.getCollablet().getDependencies()) {
            String nomeComponente = collabComponentInstance.getName();
            result.include(nomeComponente, collabComponentInstance);
            System.out.println("O componente elemento " + collabComponentInstance.getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona os filhos.
        for (Collablet collabletInstance : siteInstance.getCollablet().getSubordinateds()) {
            String nomeComponente = collabletInstance.getName();
            result.include(nomeComponente, collabletInstance);
            System.out.println("O componente filho " + collabletInstance.getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }

        // Adiciona o antecessores.
        for (Collablet pai : siteInstance.getCollablet().getHierarchy()) {
            String nomeComponente = pai.getName();
            result.include(nomeComponente, pai);
            System.out.println("O componente antecessor " + pai.getCod() + " foi adicionado na requisição com o nome " + nomeComponente);
        }
    }
}
