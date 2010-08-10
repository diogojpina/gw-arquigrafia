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

import br.org.groupwareworkbench.core.bd.DAOFactory;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoDAO;
import br.org.groupwareworkbench.core.bd.DatabaseTester;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.Collablet;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class PhotoDAOTest {

    private DatabaseTester db;
    private EntityManager em;
    private Collablet collablet;

    private PhotoDAO dao;
    private Photo photo1;
    private Photo photo2;
    private List<Photo> allPhotos;
    private List<Photo> notAllPhotos;
    private Date date;

    @Before
    public void setUp() {
        db = new DatabaseTester();
        em = EntityManagerProvider.getEntityManager();
        collablet = db.makeCollablet(PhotoMgrInstance.class);

        dao = DAOFactory.get(PhotoDAO.class);
        date = Calendar.getInstance().getTime();
        populateDatabase();
    }

    @After
    public void tearDown() {
        db.close();
    }

    private void populateDatabase() {
        em.getTransaction().begin();
        allPhotos = new ArrayList<Photo>(10);
        notAllPhotos = new ArrayList<Photo>(9);

        photo1 = new Photo();
        photo1.setIdInstance(collablet.getId());
        photo1.setNome("foto Um");
        photo1.setLugar("usp");
        photo1.setDescricao("teste da foto um");
        photo1.setData(date);
        photo1.setNomeArquivo("fotoum.jpg");
        allPhotos.add(photo1);
        em.persist(photo1);

        photo2 = new Photo();
        photo2.setIdInstance(collablet.getId());
        photo2.setNome("foto Dois");
        photo2.setLugar("wherever");
        photo2.setDescricao("this is a short description");
        photo2.setData(date);
        photo2.setNomeArquivo("fotodois.jpg");
        allPhotos.add(photo2);
        notAllPhotos.add(photo2);
        em.persist(photo2);

        for (int i = 3; i <= 10; i++) {
            Photo p = new Photo();
            p.setIdInstance(collablet.getId());
            p.setNome("foto " + i);
            p.setLugar("wherever");
            p.setDescricao("this is a short description");
            p.setData(date);
            p.setNomeArquivo("foto" + i + ".jpg");
            allPhotos.add(p);
            notAllPhotos.add(p);
            em.persist(p);
        }

        em.getTransaction().commit();
    }

    @Test
    public void testFindPhotoByNome() {
        List<Photo> ret = dao.busca("ois");

        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo2, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByNomeOuLugarDescricaoData() {
        List<Photo> ret = dao.busca("ois", "", "", null);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo2, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByLugar() {
        List<Photo> ret = dao.busca("", "usp", "", null);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo1, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByDescricao() {
        List<Photo> ret = dao.busca("", "", "this is a short", null);
        Assert.assertEquals(9, ret.size());
        Assert.assertFalse(ret.contains(photo1));
        Assert.assertTrue(ret.containsAll(notAllPhotos));
        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void testFindPhotoByLugarEData() {
        List<Photo> ret = dao.busca("", "usp", "", date);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo1, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByDescricaoEData() {
        List<Photo> ret = dao.busca("", "", "this is a", date);
        Assert.assertEquals(9, ret.size());
        Assert.assertFalse(ret.contains(photo1));
        Assert.assertTrue(ret.containsAll(notAllPhotos));

        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void testFindPhotoByData() {
        List<Photo> ret = dao.busca("", "", "", date);
        Assert.assertEquals(10, ret.size());
        Assert.assertTrue(ret.containsAll(allPhotos));
        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void listPhotoByPageTest() {
        List<Photo> ret = dao.listPhotoByPage(3, 1);
        Assert.assertEquals(3, ret.size());
        Assert.assertEquals(allPhotos.get(3), ret.get(0));
        Assert.assertEquals(allPhotos.get(4), ret.get(1));
        Assert.assertEquals(allPhotos.get(5), ret.get(2));
    }
}
