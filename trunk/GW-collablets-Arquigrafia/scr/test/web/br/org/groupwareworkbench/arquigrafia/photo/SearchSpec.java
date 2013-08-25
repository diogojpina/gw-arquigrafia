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

import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import br.org.groupwareworkbench.collablet.coord.user.LoginPage;
import br.org.groupwareworkbench.util.PhotoPage;

public class SearchSpec {

    private WebDriver driver;
    private PhotoPage photos;
    private LoginPage loginPage;
    private SearchPage searchs;
        
    
    @Before
    public void setUp() {
        driver = new FirefoxDriver();
        photos = new PhotoPage(driver);
        loginPage = new LoginPage(driver);
        searchs = new SearchPage(driver);
    }

    @After
    public void stop() {
        driver.close();
    }

    @Test
    public void shouldNotReturnDataSearchForWordsConsideredStopWord() {

        searchs.visit().fill("a").find();
        
        assertTrue(searchs.message("A palavra \"a\" não é considerada nas buscas por retornar muitos resultados."));
    }

    @Test
    public void shouldReturnDataSearch() {
        
        loginPage.visit().signIn("admin",  "123");

        photos.visit().addImage().acceptedTheTerms().fill("Museu Rodin, Palacete das Artes").save();

        searchs.visit().fill("Museu").find();
        
        assertTrue(searchs.message("Museu Rodin, Palacete das Artes"));
    }


}
