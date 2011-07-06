/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
*    This project was/is sponsored by RNP and FAPESP.
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
package br.org.groupwareworkbench.collablet.coop.album;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import br.org.groupwareworkbench.core.framework.Collablet;

import br.org.groupwareworkbench.tests.DatabaseTester;
import br.org.groupwareworkbench.tests.Fruit;
import br.org.groupwareworkbench.tests.GWRunner;

@RunWith(GWRunner.class)
public class AlbumTest {

    private DatabaseTester db;
    private EntityManager em;

    private Collablet c;
    private Fruit fh1;
    private Fruit fh2;
    private Fruit fh3;

    @Before
    public void setUp() {
        db = null;
        em = null;

        fh1 = new Fruit();
        fh1.setName("apple");
        
        fh2 = new Fruit();
        fh2.setName("orange");
        
        fh3 = new Fruit();
        fh3.setName("grape");
        
        c = new Collablet("Cool Collablet");
    }

    private void setUpPersistence() {
        db = new DatabaseTester();
        em = db.getEntityManager();
        
        em.getTransaction().begin();
        em.persist(fh1);
        em.persist(fh2);
        em.persist(fh3);
        em.getTransaction().commit();
    }

    @After
    public void tearDown() {
        if (db != null) db.close();
    }

    // Database populating methods.

    private void persistOthers() {
        em.persist(c);
        em.persist(fh1);
        em.persist(fh2);
        em.persist(fh3);
    }

    private Album completeAlbum() {
        Album a = new Album();
        a.setCollablet(c);
        a.setTitle("Album1");
        a.add(fh1);
        a.add(fh2);
        a.add(fh3);
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
        Collablet d = new Collablet("Other collablet");
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

    // Tagged objects tests.

    private void verifyObjects(Album a, boolean shouldHavePh1, boolean shouldHavePh2, boolean shouldHavePh3) {
        int count = (shouldHavePh1 ? 1 : 0) + (shouldHavePh2 ? 1 : 0) + (shouldHavePh3 ? 1 : 0);
        Assert.assertEquals(count, a.getSize());

        List<Object> objects = a.getObjects();
        Assert.assertEquals(count, objects.size());
        Assert.assertEquals(shouldHavePh1, objects.contains(fh1));
        Assert.assertEquals(shouldHavePh2, objects.contains(fh2));
        Assert.assertEquals(shouldHavePh3, objects.contains(fh3));
        Assert.assertEquals(shouldHavePh1, a.contains(fh1));
        Assert.assertEquals(shouldHavePh2, a.contains(fh2));
        Assert.assertEquals(shouldHavePh3, a.contains(fh3));
    }

    @Test
    public void testAssignmentsStartingState() {
        Album a = new Album();
        Assert.assertEquals(0, a.getSize());
        Assert.assertTrue(a.getObjects().isEmpty());
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
        verifyObjects(x, true, true, true);

        x.remove(fh2);

        em.getTransaction().begin();
        em.merge(x);
        em.getTransaction().commit();
        em.detach(x);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertNotSame(x, y);
        verifyObjects(y, true, false, true);
    }

    // Test assignments list consistency.

    private void checkList(Object... elems) {
        List<Object> list = Arrays.asList(elems);
        Assert.assertTrue(list.contains(fh1));
        Assert.assertTrue(list.contains(fh2));
        Assert.assertTrue(list.contains(fh3));
    }

    @Test(expected=UnsupportedOperationException.class)
    public void testObjectsImmutabilityOnAdding() {
        setUpPersistence();
        Album a = completeAlbum();
        List<Object> objects = a.getObjects();
        objects.add(new Fruit());
    }

    @Test(expected=UnsupportedOperationException.class)
    public void testObjectsImmutabilityOnRemoving() {
        setUpPersistence();
        Album a = completeAlbum();
        List<Object> objects = a.getObjects();
        objects.remove(fh2);
    }

    @Test(expected=UnsupportedOperationException.class)
    public void testObjectsImmutabilityOnIteratorRemoving() {
        setUpPersistence();
        Album a = completeAlbum();
        Iterator<Object> it = a.getObjects().iterator();
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
        verifyObjects(x, true, true, true);
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
        verifyObjects(x, true, true, true);
    }

    @Test
    public void testUpdateInsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        a.remove(fh2);
        a.setTitle("album1");
        em.getTransaction().begin();
        a.save();
        em.getTransaction().commit();
        em.detach(a);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertEquals("album1", y.getTitle());
        verifyObjects(y, true, false, true);
    }

    @Test
    public void testUpdateOutsideTransaction() {
        setUpPersistence();
        Album a = completePersistedAlbum();

        a.remove(fh2);
        a.setTitle("album1");
        a.save();
        em.detach(a);

        Album y = em.find(Album.class, a.getId());
        Assert.assertNotSame(a, y);
        Assert.assertEquals("album1", y.getTitle());
        verifyObjects(y, true, false, true);
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
