package br.org.groupwareworkbench.arquigrafia.imports;

import static org.junit.Assert.assertEquals;

import java.io.File;

import javax.persistence.EntityManager;

import org.jstryker.database.DBUnitHelper;
import org.jstryker.database.JPAHelper;
import org.junit.After;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;

public class PhotoImporterTest {
    private static final String DATASET_PHOTO = "/br/org/groupwareworkbench/arquigrafia/photo/Photo.xml";

    private PhotoImporter importer;
    private String userName = "acervofau";
    private static final String basePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/tests";
    private DBUnitHelper dbUnitHelper = new DBUnitHelper();

    @BeforeClass
    public static void beforeClass() {
        JPAHelper.entityManagerFactory("TestUnit");
    }

    @Before
    public void setUp() throws InterruptedException {

        EntityManager manager = JPAHelper.currentEntityManager();
        EntityManagerProvider.setEntityManager(manager);
        importer = new PhotoImporter(userName, basePath);

    }

    @After
    public void tearDown() {
        String path = basePath + File.separator + "2013-12-05-Andrea Augusta de Aguiar.ods.log";
        new File(path).delete();
        dbUnitHelper.deleteAll(DATASET_PHOTO);
        JPAHelper.close();
    }

    
    @Test
    public void shouldImportPhotosWithTags() {
        
        importer.buildImportImages();
        
        assertEquals(new Long(10), Photo.countAll());
        assertEquals(new Long(32), Tag.countAll());
        
    }
    
    
    
    
    
    
}
