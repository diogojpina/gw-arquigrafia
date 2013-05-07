package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.List;

import javax.persistence.EntityManager;

import static junit.framework.Assert.*;

import org.hibernate.search.jpa.FullTextEntityManager;
import org.jstryker.database.DBUnitHelper;
import org.jstryker.database.JPAHelper;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.util.Pagination;

public class PhotoTest {

    private static final String DATASET_PHOTO = "/br/org/groupwareworkbench/arquigrafia/photo/Photo.xml";

    private DBUnitHelper dbUnitHelper = new DBUnitHelper();

    private Collablet collablet;
    
    private Pagination pagination;
    

    @BeforeClass
    public static void beforeClass() {
        JPAHelper.entityManagerFactory("TestUnit");
    }


    @Before
    public void setUp() throws InterruptedException {
        dbUnitHelper.insert(DATASET_PHOTO);

        EntityManager manager = JPAHelper.currentEntityManager();
        EntityManagerProvider.setEntityManager(manager);
        FullTextEntityManager fullTextEntityManager = org.hibernate.search.jpa.Search.getFullTextEntityManager(manager);
        fullTextEntityManager.createIndexer().startAndWait();

        collablet = new Collablet(7l, "photoMgr");
        pagination = new Pagination(1, 10);

    }

    @After
    public void tearDown() {
        JPAHelper.close();
        dbUnitHelper.deleteAll(DATASET_PHOTO);
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
