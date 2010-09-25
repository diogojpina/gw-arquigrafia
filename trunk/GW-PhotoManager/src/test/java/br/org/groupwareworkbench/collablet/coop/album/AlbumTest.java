package br.org.groupwareworkbench.collablet.coop.album;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.core.bd.DatabaseTester;
import br.org.groupwareworkbench.core.framework.Collablet;

public class AlbumTest {

    private DatabaseTester db;
    private EntityManager em;

    private Collablet c;
    private Photo ph1;
    private Photo ph2;
    private Photo ph3;

    @Before
    public void setUp() {
        db = null;
        em = null;

        ph1 = new Photo();
        ph1.setDataCriacao(new Date());
        ph1.setNome("photo1");
        ph1.setNomeArquivo("path1");
        
        ph2 = new Photo();
        ph2.setDataCriacao(new Date());
        ph2.setNome("photo2");
        ph2.setNomeArquivo("path2");
        
        ph3 = new Photo();
        ph3.setDataCriacao(new Date());
        ph3.setNome("photo3");
        ph3.setNomeArquivo("path3");
        
        c = new Collablet();
        c.setName("Cool Collablet");
    }

    private void setUpPersistence() {
        db = new DatabaseTester();
        em = db.getEntityManager();
    }

    @After
    public void tearDown() {
        if (db != null) db.close();
    }

    // Databse populating methods.

    private void persistOthers() {
        em.persist(c);
        em.persist(ph1);
        em.persist(ph2);
        em.persist(ph3);
    }

    private Album completeAlbum() {
        Album a = new Album();
        a.setCollablet(c);
        a.setTitle("Album1");
        a.add(ph1);
        a.add(ph2);
        a.add(ph3);
        return a;
    }

    private void persistAll(Album a) {
        em.getTransaction().begin();
        persistOthers();
        em.persist(a);
        em.getTransaction().commit();
    }

    private Album completePersistedAlbum() {
        Album a = completeAlbum();
        persistAll(a);
        return a;
    }

    // Id test.
    @Test
    public void testIdPersistence() {
        setUpPersistence();
        Album a = new Album();

        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();

        Assert.assertNotNull(a.getId());
    }

    // Name tests.

    @Test
    public void testNameStartingState() {
        Album a = new Album();
        Assert.assertNull(a.getTitle());
    }

    @Test
    public void testPropertiesSetAndGet() throws ParseException {
        Album a = new Album();
        SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");  
        a.setTitle("album1");
        Assert.assertEquals("album1", a.getTitle());
        a.setCreationDate(formatador.parse("24/09/2010"));
        Assert.assertEquals(formatador.parse("24/09/2010"), a.getCreationDate());
        a.setUpdateDate(formatador.parse("27/09/2010"));
        Assert.assertEquals(formatador.parse("27/09/2010"), a.getUpdateDate());
        
    }

    @Test
    public void testNamePersistence() {
        setUpPersistence();
        Album a = new Album();
        a.setTitle("AlbumX");

        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();
        em.clear();

        Album x = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, x);
        Assert.assertEquals("AlbumX", x.getTitle());
    }

    // Collablet association tests.

    @Test
    public void testCollabletAssociationStartingState() {
        Album a = new Album();
        Assert.assertNull(a.getCollablet());
    }

    @Test
    public void testCollabletSetAndGet() {
        Album a = new Album();
        Collablet d = new Collablet();
        a.setCollablet(c);
        Assert.assertEquals(c, a.getCollablet());
        a.setCollablet(d);
        Assert.assertEquals(d, a.getCollablet());
    }

    @Test
    public void testCollabletAssociationPersistence() {
        setUpPersistence();
        Album a = new Album();
        a.setCollablet(c);

        em.getTransaction().begin();
        em.persist(c);
        em.persist(a);
        em.getTransaction().commit();
        em.clear();

        Album x = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, x);
        Assert.assertEquals(c, a.getCollablet());
    }

    @Test
    public void testNameAndCollabletUniqueness() {
        setUpPersistence();
        Album a1 = new Album();
        a1.setTitle("album1");
        a1.setCollablet(c);

        Album a2 = new Album();
        a2.setTitle("album2");
        a2.setCollablet(c);

        em.getTransaction().begin();
        em.persist(c);
        em.persist(a1);
        em.persist(a2);
        em.getTransaction().commit();
        em.clear();

        a2.setTitle("album1");

        try {
            em.getTransaction().begin();
            em.merge(a2);
            em.getTransaction().commit();
            Assert.fail();
        } catch (PersistenceException e) {
            // Ignore.
        }
    }

    // Tagged objects tests.

    private void verifyPhotos(Album a, boolean shouldHavePh1, boolean shouldHavePh2, boolean shouldHavePh3) {
        int count = (shouldHavePh1 ? 1 : 0) + (shouldHavePh2 ? 1 : 0) + (shouldHavePh3 ? 1 : 0);
        Assert.assertEquals(count, a.getSize());

        List<Photo> photos = a.getPhotos();
        Assert.assertEquals(count, photos.size());
        Assert.assertEquals(shouldHavePh1, photos.contains(ph1));
        Assert.assertEquals(shouldHavePh2, photos.contains(ph2));
        Assert.assertEquals(shouldHavePh3, photos.contains(ph3));
        Assert.assertEquals(shouldHavePh1, a.contains(ph1));
        Assert.assertEquals(shouldHavePh2, a.contains(ph2));
        Assert.assertEquals(shouldHavePh3, a.contains(ph3));
    }

    @Test
    public void testAssignmentsStartingState() {
        Album a = new Album();
        Assert.assertEquals(0, a.getSize());
        Assert.assertTrue(a.getPhotos().isEmpty());
    }

    @Test(expected=IllegalArgumentException.class)
    public void testNullContains() {
        Album a = new Album();
        a.contains(null);
    }

    @Test
    public void testAssignmentsPersistence() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        em.detach(a);
        Album x = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, x);
        verifyPhotos(x, true, true, true);

        x.remove(ph2);

        em.getTransaction().begin();
        em.merge(x);
        em.getTransaction().commit();
        em.detach(x);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertNotSame(x, y);
        verifyPhotos(y, true, false, true);
    }

    // Test assignments list consistency.

    private void checkList(Photo... elems) {
        List<Photo> list = Arrays.asList(elems);
        Assert.assertTrue(list.contains(ph1));
        Assert.assertTrue(list.contains(ph2));
        Assert.assertTrue(list.contains(ph3));
    }

    
    @Test(expected=UnsupportedOperationException.class)
    public void testPhotosImmutabilityOnAdding() {
        Album a = completeAlbum();
        List<Photo> photos = a.getPhotos();
        photos.add(new Photo());
    }

    @Test(expected=UnsupportedOperationException.class)
    public void testPhotosImmutabilityOnRemoving() {
        Album a = completeAlbum();
        List<Photo> photos = a.getPhotos();
        photos.remove(ph2);
    }

    @Test(expected=UnsupportedOperationException.class)
    public void testPhotosImmutabilityOnIteratorRemoving() {
        Album a = completeAlbum();
        Iterator<Photo> it = a.getPhotos().iterator();
        it.next();
        it.remove();
    }

    // Save and delete tests.

    @Test
    public void testInsertInsideTransaction() {
        setUpPersistence();
        Album a = completeAlbum();

        em.getTransaction().begin();
        persistOthers();
        a.save();
        em.getTransaction().commit();
        em.detach(a);

        Album x = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, x);
        verifyPhotos(x, true, true, true);
    }

    @Test
    public void testInsertOutsideTransaction() {
        setUpPersistence();
        Album a = completeAlbum();

        em.getTransaction().begin();
        persistOthers();
        em.getTransaction().commit();

        a.save();
        em.detach(a);

        Album x = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, x);
        verifyPhotos(x, true, true, true);
    }

    @Test
    public void testUpdateInsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        a.remove(ph2);
        a.setTitle("album1");
        em.getTransaction().begin();
        a.save();
        em.getTransaction().commit();
        em.detach(a);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertEquals("album1", y.getTitle());
        verifyPhotos(y, true, false, true);
    }

    @Test
    public void testUpdateOutsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        a.remove(ph2);
        a.setTitle("album1");
        a.save();
        em.detach(a);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertEquals("album1", y.getTitle());
        verifyPhotos(y, true, false, true);
    }

    @Test
    public void testDeleteUnsaved() {
        setUpPersistence();
        Album a = completeAlbum();
        a.delete();
    }

    @Test
    public void testDeleteInsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        em.getTransaction().begin();
        a.delete();
        em.getTransaction().commit();

        Assert.assertNull(em.find(Album.class, a.getId()));
    }

    @Test
    public void testDeleteOutsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        a.delete();

        Assert.assertNull(em.find(Album.class, a.getId()));
    }
}
