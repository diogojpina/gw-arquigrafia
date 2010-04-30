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

	@Test
	public void testFindPhotoByNomeOuLugarDescricaoData(){
		Photo um = new Photo();
		//um.setId();;
		Date date=Calendar.getInstance().getTime();
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
		
		dao.save(um , true);
		dao.save(dois, true);
		
		List<Photo> ret=dao.busca("ois", "", "", null, 1L);		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Dois", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		
		ret=dao.busca("", "usp", "", null, 1L);		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Um", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		ret=dao.busca("", "", "this is a short", null, 1L);		
		Assert.assertEquals(1, ret.size());
		Assert.assertEquals("foto Dois", ret.get(0).getNome() );
		Assert.assertNotNull(ret.get(0).getId());
		
		ret=dao.busca("", "usp", "", date, 1L);		
		Assert.assertEquals(1, ret.size());	
		
		ret=dao.busca("", "", "this is a", date, 1L);		
		Assert.assertEquals(1, ret.size());
		
		ret=dao.busca("", "", "", date, 1L);		
		Assert.assertEquals(2, ret.size());			
	}
	
}
