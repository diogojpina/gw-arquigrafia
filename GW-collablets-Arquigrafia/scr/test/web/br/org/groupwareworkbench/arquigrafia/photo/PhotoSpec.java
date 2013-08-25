package br.org.groupwareworkbench.arquigrafia.photo;

import static org.junit.Assert.assertTrue;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import br.org.groupwareworkbench.collablet.coord.user.LoginPage;
import br.org.groupwareworkbench.util.PhotoPage;

public class PhotoSpec {

    private WebDriver driver;

    private LoginPage loginPage;
    
    private PhotoPage photos;

    @Before
    public void setUp() {
        driver = new FirefoxDriver();
        loginPage = new LoginPage(driver);
        photos = new PhotoPage(driver);

        loginPage.visit().signIn("admin",  "123");
    }
    
    @After
    public void tearDown() {
        driver.close();
    }

    @Test
    public void shouldUpload() {

         photos.visit().addImage().acceptedTheTerms().save();
        
         assertTrue(photos.message("Imagem adicionada com sucesso."));
    }

    @Test
    public void shouldNotUploadWithoutAttachingImage() {

         photos.visit().acceptedTheTerms().save();
        
         assertTrue(photos.message("O arquivo deve ser informado."));
    }
    
    @Test
    public void shouldDestroyAPhotoUploaded() {

        photos.visit().addImage().acceptedTheTerms().save();
        photos.visitFisrtPhoto().destroy();
    }
    
    @Test
    public void shouldAddimageToBookmark() {

        photos.visit().addImage().acceptedTheTerms().save();
        
        photos.visitFisrtPhoto().addToBookmark().save();
    }
    
    @Test
    public void shouldAvaluateAnImage() {

        photos.visit().addImage().acceptedTheTerms().save();
        photos.visitFisrtPhoto().AvaluateAnImage();
        
        assertTrue(photos.message("Sua avaliação foi salva, veja agora a média das avaliações."));
    }
    
    

}
