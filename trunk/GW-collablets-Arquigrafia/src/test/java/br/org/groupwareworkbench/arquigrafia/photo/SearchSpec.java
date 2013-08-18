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

import org.junit.After;
import org.junit.Test;

import br.org.groupwareworkbench.core.common.CommonWebSteps;

public class SearchSpec {

    private CommonWebSteps cws = new CommonWebSteps();
        
    @After
    public void stop() {
        cws.closeAndQuit();
    }

    @Test
    public void shouldNotReturnDataSearchForWordsConsideredStopWord() {
        cws.timeout();
        cws.typeAtField("aquele", "q");
        cws.submitFormForClass("search_bar_button");
        cws.checkMessage("Nenhuma imagem encontrada");
    }



}
