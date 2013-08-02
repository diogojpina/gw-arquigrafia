package br.org.groupwareworkbench.arquigrafia.photo;

import static junit.framework.Assert.assertEquals;

import java.util.List;

import javax.persistence.EntityManager;

import org.hibernate.search.jpa.FullTextEntityManager;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.util.Pagination;
import br.org.groupwareworkbench.tests.DatabaseTester;

public class PhotoTest {

    private Collablet collablet;
    
    private Pagination pagination;
    
    private PhotoBuilder builder;

    @Before
    public void setUp() throws InterruptedException {

        DatabaseTester db = new DatabaseTester();
        EntityManager manager =  db.getEntityManager();
        
        builder = new PhotoBuilder().create();
        
        FullTextEntityManager fullTextEntityManager = org.hibernate.search.jpa.Search.getFullTextEntityManager(manager);
        fullTextEntityManager.createIndexer().startAndWait();
        
        collablet = builder.getCollablet();
        pagination = new Pagination(1, 10);

    }

    @After
    public void tearDown() {
        builder.destroy();
    }

    @Test
    public void shouldReturnTheAmountOfPhotosFoundInSearchForTerm() {
        Long count = Photo.countByAttribute(collablet, "city", "sao");
        assertEquals(new Long(3), count);
    }
    
    @Test
    public void firstResultOfTheSearchForImagesShouldBeTheMostRelevant() {
        List<Photo> images = Photo.findByAttribute(collablet, "city", "Sao Paulo", pagination);
        Photo imageMoreRemevent = images.get(0);
        Photo imageLessRemevent = images.get(images.size()-1);
        assertEquals("São Paulo", imageMoreRemevent.getCity());
        assertEquals("Sao", imageLessRemevent.getCity());
    }
    
    @Test
    public void shouldReturnImagesForAnyRelevantPartOfTheAuthorSName() {
        List<Photo> images = Photo.findByAttribute(collablet, "imageAuthor", "MELLO,", pagination);
        Photo image = images.get(0);
        assertEquals("MELLO, Eduardo Augusto Kneese de", image.getImageAuthor());
    }
    
    @Test
    public void shouldRemoveSpacesAtTheBeginningAndEndOfTheSearchValue() {
        List<Photo> images = Photo.findByAttribute(collablet, "imageAuthor", " MELLO Eduardo Augusto Kneese de ", pagination);
        Photo image = images.get(0);
        assertEquals(4, images.size());
        assertEquals("MELLO, Eduardo Augusto Kneese de", image.getImageAuthor());
    }
    
    
}
