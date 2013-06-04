package br.org.groupwareworkbench.arquigrafia.imports;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

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
import br.org.groupwareworkbench.core.framework.Collablet;

public class PhotoImporterTest {
    private static final String DATASET_PHOTO = "/br/org/groupwareworkbench/arquigrafia/photo/Photo.xml";

    private PhotoImporter importer;
    private String userName = "acervofau";
    private static final String basePath = "./src/test/resources/br/org/groupwareworkbench/arquigrafia/imports/tests";
    private DBUnitHelper dbUnitHelper = new DBUnitHelper();

    private Collablet tagMgr;

    private Collablet photoMgr;

    @BeforeClass
    public static void beforeClass() {
        JPAHelper.entityManagerFactory("TestUnit");
    }

    @Before
    public void setUp() throws InterruptedException {

        EntityManager manager = JPAHelper.currentEntityManager();
        EntityManagerProvider.setEntityManager(manager);
        tagMgr = new Collablet(19l, "tagMgr");
        photoMgr = new Collablet(7l, "photoMgr");
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
        assertPhotosWithTags();
        
    }

    private void assertPhotosWithTags() {
        LinkedList<Integer> amount = amountOfPhotoTags();
        
        List<Photo> photos = Photo.list(photoMgr);
        for (Photo photo: photos) {
            assertEquals((int)amount.pop(), Tag.listByObject(tagMgr, photo).size());
        }
    }

    private LinkedList<Integer> amountOfPhotoTags() {
        
        return new LinkedList<Integer>() {{
            push(15);
            push(15);
            push(12);
            push(18);
            push(12);
            push(12);
            push(14);
            push(12);
            push(13);
            push(13);
        }};
    }
    
    
    
    
    
    
}
