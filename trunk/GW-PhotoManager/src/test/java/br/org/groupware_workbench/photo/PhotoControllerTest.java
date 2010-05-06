package br.org.groupware_workbench.photo;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.stream.FileImageInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.swing.ImageIcon;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
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
        result = new MockResult();

        requestInfo = mock(RequestInfo.class);
        httpServletRequest = mock(HttpServletRequest.class);
        photoInstance = mock(PhotoMgrInstance.class);

        controller = new PhotoController(result, new MockValidator(), httpServletRequest, requestInfo);
        when(view.redirectTo(PhotoController.class)).thenReturn(controller);

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
        when(photoInstance.getCollabElementInstances()).thenReturn(new ArrayList<CollabElementInstance>());
        when(photoInstance.buscaFoto("fo")).thenReturn(null);

        try {
            controller.buscaFoto("fo", photoInstance);
            Assert.fail();
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

        Photo[] fotos = {um, dois};

        List<Photo> fotosResult = (List<Photo>) result.included("fotos");
        Assert.assertArrayEquals(fotosResult.toArray(), fotos);

    }

    @Test
    public void shouldFazerBuscaAvancada() {
        when(photoInstance.getCollabElementInstances()).thenReturn(new ArrayList<CollabElementInstance>());

        try {
            controller.buscaFotoAvancada("", "", "", null, photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());
            Assert.assertEquals("Nenhum campo foi preenchido.", errors.get(0).getMessage());
        }

        when(photoInstance.buscaFotoAvancada("fotoun", "", "", null)).thenReturn(photos);
        controller.buscaFotoAvancada("fotoun", "", "", null, photoInstance);

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

        Photo[] fotos = {um, dois};

        List<Photo> fotosResult = (List<Photo>) result.included("fotos");
        Assert.assertArrayEquals(fotosResult.toArray(), fotos);
    }

    @Test
    public void shouldSave() {
        Photo um = new Photo();
        um.setIdInstance(1);
        um.setNome("");

        String[] mesagens = {"O nome é obrigatório.", "Uma imagem é obrigatória.", "Não foi possível redimensionar a imagem."};
        try {
            controller.save(um, null, photoInstance);
            Assert.fail();
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

        try {
            controller.save(um, null, photoInstance);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> erros = e.getErrors();
            List<String> outMesagens = new ArrayList<String>();
            for (Message message : erros) {
                outMesagens.add(message.getMessage());
            }
            Assert.assertEquals(3, erros.size());
            Assert.assertTrue(outMesagens.contains(mesagens[1]));
        }
        
        InputStream imagen=null;
        
        try {
            //imagen = new FileInputStream("src/test/resources/predio.jpg");
            imagen=new BufferedInputStream(new FileInputStream("src/test/resources/predio.jpg")); 
            String str=imagen.toString();
        
           
        } catch (FileNotFoundException e1) {
            // TOtDO Auto-generated catch block
            e1.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }                       
                               
        UploadedFile file = mock(UploadedFile.class);
        when(file.getFile()).thenReturn(imagen);
        when(file.getFileName()).thenReturn("fotoun.jpg");
        
        controller = new PhotoController(result, new MockValidator(), httpServletRequest, requestInfo);
        when(view.redirectTo(PhotoController.class)).thenReturn(controller);

        try {
            controller.save(um, file, photoInstance);
            //Assert.fail();
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
