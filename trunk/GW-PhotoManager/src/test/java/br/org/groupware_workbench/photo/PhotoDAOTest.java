package br.org.groupware_workbench.photo;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;

import br.org.groupware_workbench.commons.bd.jpa.EntityManagerProvider;
import br.org.groupware_workbench.coreutils.DAOFactory;
import br.org.groupware_workbench.photo.Photo;
import br.org.groupware_workbench.photo.PhotoDAO;

public class PhotoDAOTest {

    private PhotoDAO dao;
    private Photo photo1;
    private Photo photo2;
    private Photo photo3;
    private Photo photo4;
    private Photo photo5;
    private Photo photo6;
    private Photo photo7;
    private Photo photo8;
    private Photo photo9;
    private Photo photo10;
    private Date date;

    @Before
    public void setUp() {
        EntityManager em = Persistence.createEntityManagerFactory("EntidadesPU2").createEntityManager();
        EntityManagerProvider.setEntityManager(em);
        dao = DAOFactory.get(PhotoDAO.class);
        date = Calendar.getInstance().getTime();
        populateDatabase();
    }

    private void populateDatabase() {
        photo1 = new Photo();
        photo1.setIdInstance(1);
        photo1.setNome("foto Um");
        photo1.setLugar("usp");
        photo1.setDescricao("teste da foto um");
        photo1.setData(date);
        photo1.setNomeArquivo("fotoum.jpg");

        photo2 = new Photo();
        photo2.setIdInstance(1);
        photo2.setNome("foto Dois");
        photo2.setLugar("wherever");
        photo2.setDescricao("this is a short description");
        photo2.setData(date);
        photo2.setNomeArquivo("fotodois.jpg");

        photo3 = new Photo();
        photo3.setIdInstance(1);
        photo3.setNome("foto Tres");
        photo3.setLugar("wherever");
        photo3.setDescricao("this is a short description");
        photo3.setData(date);
        photo3.setNomeArquivo("fototres.jpg");

        photo4 = new Photo();
        photo4.setIdInstance(1);
        photo4.setNome("foto Quatro");
        photo4.setLugar("wherever");
        photo4.setDescricao("this is a short description");
        photo4.setData(date);
        photo4.setNomeArquivo("fotoquatro.jpg");

        photo5 = new Photo();
        photo5.setIdInstance(1);
        photo5.setNome("foto Cinco");
        photo5.setLugar("wherever");
        photo5.setDescricao("this is a short description");
        photo5.setData(date);
        photo5.setNomeArquivo("fotocinco.jpg");

        photo6 = new Photo();
        photo6.setIdInstance(1);
        photo6.setNome("foto Seis");
        photo6.setLugar("wherever");
        photo6.setDescricao("this is a short description");
        photo6.setData(date);
        photo6.setNomeArquivo("fotoseis.jpg");

        photo7 = new Photo();
        photo7.setIdInstance(1);
        photo7.setNome("foto Sete");
        photo7.setLugar("wherever");
        photo7.setDescricao("this is a short description");
        photo7.setData(date);
        photo7.setNomeArquivo("fotosete.jpg");

        photo8 = new Photo();
        photo8.setIdInstance(1);
        photo8.setNome("foto Oito");
        photo8.setLugar("wherever");
        photo8.setDescricao("this is a short description");
        photo8.setData(date);
        photo8.setNomeArquivo("fotooito.jpg");

        photo9 = new Photo();
        photo9.setIdInstance(1);
        photo9.setNome("foto Nove");
        photo9.setLugar("wherever");
        photo9.setDescricao("this is a short description");
        photo9.setData(date);
        photo9.setNomeArquivo("fotonove.jpg");

        photo10 = new Photo();
        photo10.setIdInstance(1);
        photo10.setNome("foto Dez");
        photo10.setLugar("wherever");
        photo10.setDescricao("this is a short description");
        photo10.setData(date);
        photo10.setNomeArquivo("fotodez.jpg");

        dao.save(photo1, true);
        dao.save(photo2, true);
        dao.save(photo3, true);
        dao.save(photo4, true);
        dao.save(photo5, true);
        dao.save(photo6, true);
        dao.save(photo7, true);
        dao.save(photo8, true);
        dao.save(photo9, true);
        dao.save(photo10, true);
    }

    @Test
    public void testFindPhotoByNome() {
        List<Photo> ret = dao.busca("ois", 1L);

        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo2, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByNomeOuLugarDescricaoData() {
        List<Photo> ret = dao.busca("ois", "", "", null, 1L);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo2, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByLugar() {
        List<Photo> ret = dao.busca("", "usp", "", null, 1L);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo1, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByDescricao() {
        List<Photo> ret = dao.busca("", "", "this is a short", null, 1L);
        Assert.assertEquals(9, ret.size());
        Assert.assertFalse(ret.contains(photo1));
        Assert.assertTrue(ret.contains(photo2));
        Assert.assertTrue(ret.contains(photo3));
        Assert.assertTrue(ret.contains(photo4));
        Assert.assertTrue(ret.contains(photo5));
        Assert.assertTrue(ret.contains(photo6));
        Assert.assertTrue(ret.contains(photo7));
        Assert.assertTrue(ret.contains(photo8));
        Assert.assertTrue(ret.contains(photo9));
        Assert.assertTrue(ret.contains(photo10));
        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void testFindPhotoByLugarEData() {
        List<Photo> ret = dao.busca("", "usp", "", date, 1L);
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(1, ret.size());
        Assert.assertEquals(photo1, ret.get(0));
        Assert.assertNotNull(ret.get(0).getId());
    }

    @Test
    public void testFindPhotoByDescricaoEData() {
        List<Photo> ret = dao.busca("", "", "this is a", date, 1L);
        Assert.assertEquals(9, ret.size());
        Assert.assertFalse(ret.contains(photo1));
        Assert.assertTrue(ret.contains(photo2));
        Assert.assertTrue(ret.contains(photo3));
        Assert.assertTrue(ret.contains(photo4));
        Assert.assertTrue(ret.contains(photo5));
        Assert.assertTrue(ret.contains(photo6));
        Assert.assertTrue(ret.contains(photo7));
        Assert.assertTrue(ret.contains(photo8));
        Assert.assertTrue(ret.contains(photo9));
        Assert.assertTrue(ret.contains(photo10));
        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void testFindPhotoByData() {
        List<Photo> ret = dao.busca("", "", "", date, 1L);
        Assert.assertEquals(10, ret.size());
        Assert.assertTrue(ret.contains(photo1));
        Assert.assertTrue(ret.contains(photo2));
        Assert.assertTrue(ret.contains(photo3));
        Assert.assertTrue(ret.contains(photo4));
        Assert.assertTrue(ret.contains(photo5));
        Assert.assertTrue(ret.contains(photo6));
        Assert.assertTrue(ret.contains(photo7));
        Assert.assertTrue(ret.contains(photo8));
        Assert.assertTrue(ret.contains(photo9));
        Assert.assertTrue(ret.contains(photo10));
        for (Photo p : ret) {
            Assert.assertNotNull(p.getId());
        }
    }

    @Test
    public void listPhotoByPageTest() {
        List<Photo> ret = dao.listPhotoByPage(3, 1);
        Assert.assertEquals(3, ret.size());
        Assert.assertEquals(photo4, ret.get(0));
        Assert.assertEquals(photo5, ret.get(1));
        Assert.assertEquals(photo6, ret.get(2));
    }
}
