package br.org.groupware_workbench.photo;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
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
import br.com.caelum.vraptor.util.test.MockResult;

public class PhotoControllerTest {

    private PhotoController controller;
    private PhotoMgrInstance photoInstance;
    private MockResult result;
    private LogicResult view;
    private RequestInfo requestInfo;
    private HttpServletRequest httpServletRequest;
    private List<Photo> photos;
    private Photo photo1;
    private Photo photo2;

    @Before
    public void setUp() {
        view = mock(LogicResult.class);
        result = new MockResult();

        requestInfo = mock(RequestInfo.class);
        httpServletRequest = mock(HttpServletRequest.class);
        photoInstance = mock(PhotoMgrInstance.class);

        controller = new PhotoController(result, new MockValidator(), httpServletRequest, requestInfo);
        when(view.redirectTo(PhotoController.class)).thenReturn(controller);

        photos = new ArrayList<Photo>();

        photo1 = new Photo();
        photo1.setId(1);
        photo1.setIdInstance(1);
        photo1.setNome("foto Um");
        photo1.setNomeArquivo("fotoum.jpg");
        photos.add(photo1);

        photo2 = new Photo();
        photo2.setId(2);
        photo2.setIdInstance(1);
        photo2.setNome("foto Dois");
        photo2.setNomeArquivo("fotodois.jpg");
        photos.add(photo2);
    }

    private UploadedFile getImage() {
        InputStream imagem = null;

        try {
            imagem = new BufferedInputStream(new FileInputStream(new File(this.getClass().getResource("fotoum.jpg").getFile())));
        } catch (FileNotFoundException e) {
            Assert.fail();
        } catch (IOException e) {
            Assert.fail();
        }

        UploadedFile file = mock(UploadedFile.class);
        when(file.getFile()).thenReturn(imagem);
        when(file.getFileName()).thenReturn("fotoum.jpg");

        return file;
    }

    @Test
    public void testPhotoSearchWithShortString() {
        when(photoInstance.buscaFoto("fo")).thenThrow(new AssertionError());

        try {
            controller.buscaFoto("fo", photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());
            Assert.assertEquals(PhotoController.MSG_MIN_3_LETRAS, errors.get(0).getMessage());
        }
    }

    @Test
    public void testPhotoSearchWithLongEnoughString() {
        when(photoInstance.buscaFoto("fot")).thenReturn(photos);
        controller.buscaFoto("fot", photoInstance);

        @SuppressWarnings("unchecked")
        List<Photo> fotosResult = (List<Photo>) result.included("fotos");

        Assert.assertEquals(2, fotosResult.size());
        Assert.assertTrue(fotosResult.contains(photo1));
        Assert.assertTrue(fotosResult.contains(photo2));
    }

    @Test
    public void testAdvancedSearchWithoutAnyFields() {
        try {
            controller.buscaFotoAvancada("", "", "", null, photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());
            Assert.assertEquals(PhotoController.MSG_NENHUM_CAMPO_PREENCHIDO, errors.get(0).getMessage());
        }
    }

    @Test
    public void testAdvancedSeachByName() {
        when(photoInstance.buscaFotoAvancada("fotoum", "", "", null)).thenReturn(photos);
        controller.buscaFotoAvancada("fotoum", "", "", null, photoInstance);

        @SuppressWarnings("unchecked")
        List<Photo> fotosResult = (List<Photo>) result.included("fotos");

        Assert.assertEquals(2, fotosResult.size());
        Assert.assertTrue(fotosResult.contains(photo1));
        Assert.assertTrue(fotosResult.contains(photo2));
    }

    @Test
    public void testSaveWithoutNameNorImage() {
        Photo um = new Photo();
        um.setIdInstance(1);
        um.setNome("");

        try {
            controller.save(um, null, photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(2, errors.size());

            List<String> outMesagens = new ArrayList<String>(2);
            for (Message message : errors) {
                outMesagens.add(message.getMessage());
            }
            Assert.assertTrue(outMesagens.contains(PhotoController.MSG_NOME_OBRIGATORIO));
            Assert.assertTrue(outMesagens.contains(PhotoController.MSG_IMAGEM_OBRIGATORIA));
        }
    }

    @Test
    public void testSaveWithoutImage() {
        Photo um = new Photo();
        um.setIdInstance(1);
        um.setNome("foto Um");
        um.setNomeArquivo("fotoum.jpg");

        try {
            controller.save(um, null, photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());

            List<String> outMesagens = new ArrayList<String>(2);
            for (Message message : errors) {
                outMesagens.add(message.getMessage());
            }
            Assert.assertEquals(PhotoController.MSG_IMAGEM_OBRIGATORIA, errors.get(0).getMessage());
        }
    }

    @Test
    public void testSucessfulSave() throws ValidationException {
        Photo um = new Photo();
        um.setIdInstance(1);
        um.setNome("foto Um");
        um.setNomeArquivo("fotoum.jpg");

        UploadedFile file = getImage();

        controller = new PhotoController(result, new MockValidator(), httpServletRequest, requestInfo);
        when(view.redirectTo(PhotoController.class)).thenReturn(controller);

        controller.save(um, file, photoInstance);
    }
}
