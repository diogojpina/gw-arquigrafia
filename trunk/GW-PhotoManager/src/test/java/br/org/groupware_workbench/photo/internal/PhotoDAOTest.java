package br.org.groupware_workbench.photo.internal;

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

public class PhotoDAOTest {
	private PhotoDAO dao;
		
	@Before
	public void setUp(){
		EntityManager em = Persistence.createEntityManagerFactory("EntidadesPU2").createEntityManager();
        EntityManagerProvider.setEntityManager(em);
        dao = DAOFactory.get(PhotoDAO.class);
	}
	
	@Test
	public void testFindPhotoByNome(){
		Photo um = new Photo();
		//um.setId();;
		um.setIdInstance(1);
		um.setNome("foto Um");
		um.setNomeArquivo("fotoum.jpg");

		Photo dois = new Photo();
		//dois.setId();
		dois.setIdInstance(1);
		dois.setNome("foto Dois");
		dois.setNomeArquivo("fotodois.jpg");
		
		dao.save(um , true);
		dao.save(dois, true);
		
		List<Photo> ret=dao.busca("ois", 1L);
		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Dois", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
				
	}
	
	public void populateDataBase(Date date){
	    Photo um = new Photo();
        //um.setId();;       
        um.setIdInstance(1);
        um.setNome("foto Um");
        um.setLugar("usp");
        um.setDescricao("teste da foto um");
        um.setData(date);
        um.setNomeArquivo("fotoum.jpg");

        Photo dois = new Photo();
        //dois.setId();
        dois.setIdInstance(1);
        dois.setNome("foto Dois");
        dois.setLugar("wherever");
        dois.setDescricao("this is a short description");
        dois.setData(date);
        dois.setNomeArquivo("fotodois.jpg");       
        
        
        Photo tres = new Photo();
        //dois.setId();
        tres.setIdInstance(1);
        tres.setNome("foto Tres");
        tres.setLugar("wherever");
        tres.setDescricao("this is a short description");
        tres.setData(date);
        tres.setNomeArquivo("fototres.jpg");
        
        
        Photo quatro = new Photo();
        //dois.setId();
        quatro.setIdInstance(1);
        quatro.setNome("foto Quatro");
        quatro.setLugar("wherever");
        quatro.setDescricao("this is a short description");
        quatro.setData(date);
        quatro.setNomeArquivo("fotoquatro.jpg");
        
        
        Photo cinco = new Photo();
        //dois.setId();
        cinco.setIdInstance(1);
        cinco.setNome("foto Cinco");
        cinco.setLugar("wherever");
        cinco.setDescricao("this is a short description");
        cinco.setData(date);
        cinco.setNomeArquivo("fotocinco.jpg");
        
        
        Photo seis = new Photo();
        //dois.setId();
        seis.setIdInstance(1);
        seis.setNome("foto Seis");
        seis.setLugar("wherever");
        seis.setDescricao("this is a short description");
        seis.setData(date);
        seis.setNomeArquivo("fotoseis.jpg");
        
        Photo sete = new Photo();
        //dois.setId();
        sete.setIdInstance(1);
        sete.setNome("foto Sete");
        sete.setLugar("wherever");
        sete.setDescricao("this is a short description");
        sete.setData(date);
        sete.setNomeArquivo("fotosete.jpg");
        
        Photo oito = new Photo();
        //dois.setId();
        oito.setIdInstance(1);
        oito.setNome("foto Oito");
        oito.setLugar("wherever");
        oito.setDescricao("this is a short description");
        oito.setData(date);
        oito.setNomeArquivo("fotooito.jpg");
        
        
        Photo nove = new Photo();
        //dois.setId();
        nove.setIdInstance(1);
        nove.setNome("foto Nove");
        nove.setLugar("wherever");
        nove.setDescricao("this is a short description");
        nove.setData(date);
        nove.setNomeArquivo("fotonove.jpg");
        
        Photo dez = new Photo();
        //dois.setId();
        dez.setIdInstance(1);
        dez.setNome("foto Dez");
        dez.setLugar("wherever");
        dez.setDescricao("this is a short description");
        dez.setData(date);
        dez.setNomeArquivo("fotodez.jpg");
        
        dao.save(um , true);
        dao.save(dois, true);
        dao.save(tres, true);
        dao.save(quatro , true);
        dao.save(cinco , true);
        dao.save(seis , true);
        dao.save(sete , true);
        dao.save(oito , true);
        dao.save(nove , true);
        dao.save(dez , true);
	}

	@Test
	public void testFindPhotoByNomeOuLugarDescricaoData(){
	    Date date=Calendar.getInstance().getTime();
	    populateDataBase(date);
		
		List<Photo> ret=dao.busca("ois", "", "", null, 1L);		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Dois", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		
		ret=dao.busca("", "usp", "", null, 1L);		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Um", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		ret=dao.busca("", "", "this is a short", null, 1L);		
		Assert.assertEquals(9, ret.size());
		Assert.assertEquals("foto Dois", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		ret=dao.busca("", "usp", "", date, 1L);		
		Assert.assertEquals(1, ret.size());	
		
		ret=dao.busca("", "", "this is a", date, 1L);		
		Assert.assertEquals(9, ret.size());
		
		ret=dao.busca("", "", "", date, 1L);		
		Assert.assertEquals(10, ret.size());			
	}
	
	
	@Test
	public void listPhotoByPageTest(){
	    Date date=Calendar.getInstance().getTime();
	    populateDataBase(date);	    	    
	    List<Photo> answer=dao.listPhotoByPage(3, 1);
	    Assert.assertEquals(3, answer.size());
	    Assert.assertEquals("foto Quatro", answer.get(0).getNome());
	}
	
}
