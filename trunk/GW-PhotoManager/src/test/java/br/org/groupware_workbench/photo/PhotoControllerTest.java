package br.org.groupware_workbench.photo;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.util.test.MockValidator;
import br.com.caelum.vraptor.validator.Message;
import br.com.caelum.vraptor.validator.ValidationException;
import br.com.caelum.vraptor.view.LogicResult;
import br.org.groupware_workbench.collabElement.mock.MockResult;
import br.org.groupware_workbench.collabElementFw.facade.CollabElementInstance;

public class PhotoControllerTest {
	private PhotoController controller;
	private PhotoMgrInstance photoInstance;
	private MockValidator validator;
	private MockResult result;
	private LogicResult view;
	private RequestInfo requestInfo;
	private HttpServletRequest httpServletRequest;
	private List<Photo> photos;

	@Before
	public void setUp() {
		view = mock(LogicResult.class);
		result = new MockResult(view);

		requestInfo = mock(RequestInfo.class);
		httpServletRequest = mock(HttpServletRequest.class);
		photoInstance = mock(PhotoMgrInstance.class);

		photos = new ArrayList<Photo>();

		Photo um = new Photo();
		um.setId(1);
		um.setIdInstance(1);
		um.setNome("foto Um");
		um.setNomeArquivo("fotoum.jpg");

		Photo dois = new Photo();
		dois.setId(2);
		dois.setIdInstance(1);
		dois.setNome("foto Dois");
		dois.setNomeArquivo("fotodois.jpg");

		photos.add(um);
		photos.add(dois);
	}

	@Test
	public void shouldBuscarFotosByString() {
		controller = new PhotoController(result, new MockValidator(),
				httpServletRequest, requestInfo);

		when(photoInstance.getCollabElementInstances()).thenReturn(
				new ArrayList<CollabElementInstance>());
		when(view.redirectTo(PhotoController.class)).thenReturn(controller);
		when(photoInstance.buscaFoto("fo")).thenReturn(null);

		try {
			controller.buscaFoto("fo", photoInstance);
		} catch (ValidationException e) {
			List<Message> errors = e.getErrors();
		}

		when(photoInstance.buscaFoto("fot")).thenReturn(photos);
		controller.buscaFoto("fot", photoInstance);

		Photo um = new Photo();
		um.setId(1);
		um.setIdInstance(1);
		um.setNome("foto Um");
		um.setNomeArquivo("fotoum.jpg");

		Photo dois = new Photo();
		dois.setId(2);
		dois.setIdInstance(1);
		dois.setNome("foto Dois");
		dois.setNomeArquivo("fotodois.jpg");

		Photo[] fotos = { um, dois };

		List<Photo> fotosResult = (List<Photo>) result.get("fotos");
		Assert.assertArrayEquals(fotosResult.toArray(), fotos);

	}

	@Test
	public void shouldFazerBuscaAvanzada() {
		controller = new PhotoController(result, new MockValidator(),
				httpServletRequest, requestInfo);

		when(photoInstance.getCollabElementInstances()).thenReturn(
				new ArrayList<CollabElementInstance>());
		when(view.redirectTo(PhotoController.class)).thenReturn(controller);
		

		try {
			controller.buscaFotoAvanzada("", "", "", null, photoInstance); 
		} catch (ValidationException e) {
			List<Message> errors = e.getErrors();
			Assert.assertEquals(1, errors.size());
			Assert.assertEquals("Nenhum campo prechido", errors.get(0).getMessage());
		}

		when(photoInstance.buscaFotoAvancada("fotoun", "", "", null)).thenReturn(photos); 
		controller.buscaFotoAvanzada("fotoun", "", "", null, photoInstance);

		Photo um = new Photo();
		um.setId(1);
		um.setIdInstance(1);
		um.setNome("foto Um");
		um.setNomeArquivo("fotoum.jpg");

		Photo dois = new Photo();
		dois.setId(2);
		dois.setIdInstance(1);
		dois.setNome("foto Dois");
		dois.setNomeArquivo("fotodois.jpg");

		Photo[] fotos = { um, dois };

		List<Photo> fotosResult = (List<Photo>) result.get("fotos");
		Assert.assertArrayEquals(fotosResult.toArray(), fotos);

	}

	@Test
	public void shouldSave() {
		controller = new PhotoController(result, new MockValidator(),
				httpServletRequest, requestInfo);
		when(view.redirectTo(PhotoController.class)).thenReturn(controller);

		Photo um = new Photo();
		um.setIdInstance(1);
		um.setNome("");

		String[] mesagens = { "O nome é obrigatorio",
				"Uma imagem é obrigatoria", "Não foi possivel escalar a imagen" };
		try {
			controller.save(um, null, photoInstance);
		} catch (ValidationException e) {
			List<Message> erros = e.getErrors();
			List<String> outMesagens = new ArrayList<String>();
			for (Message message : erros) {
				outMesagens.add(message.getMessage());
			}
			Assert.assertEquals(2, erros.size());
			Assert.assertTrue(outMesagens.contains(mesagens[0]));
			Assert.assertTrue(outMesagens.contains(mesagens[1]));
		}

		um.setNome("foto Um");
		um.setNomeArquivo("fotoum.jpg");

		controller = new PhotoController(result, new MockValidator(),
				httpServletRequest, requestInfo);
		when(view.redirectTo(PhotoController.class)).thenReturn(controller);

		try {
			controller.save(um, null, photoInstance);
		} catch (ValidationException e) {
			List<Message> erros = e.getErrors();
			List<String> outMesagens = new ArrayList<String>();
			for (Message message : erros) {
				outMesagens.add(message.getMessage());
			}
			Assert.assertEquals(1, erros.size());
			Assert.assertTrue(outMesagens.contains(mesagens[1]));
		}

		UploadedFile file = mock(UploadedFile.class);
		um.setNomeArquivo("fotoum.jpg");

		controller = new PhotoController(result, new MockValidator(),
				httpServletRequest, requestInfo);
		when(view.redirectTo(PhotoController.class)).thenReturn(controller);

		try {
			controller.save(um, file, photoInstance);
		} catch (ValidationException e) {
			List<Message> erros = e.getErrors();
			List<String> outMesagens = new ArrayList<String>();
			for (Message message : erros) {
				outMesagens.add(message.getMessage());
			}
			Assert.assertEquals(1, erros.size());
			Assert.assertTrue(outMesagens.contains(mesagens[2]));
		}
	}
}
