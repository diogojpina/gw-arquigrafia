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
package br.org.groupwareworkbench.arquigrafia.photo;

import static org.mockito.Mockito.*;
import br.com.caelum.vraptor.core.Converters;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.interceptor.multipart.UploadedFile;
import br.com.caelum.vraptor.util.test.MockResult;
import br.com.caelum.vraptor.util.test.MockValidator;
import br.com.caelum.vraptor.validator.Message;
import br.com.caelum.vraptor.validator.ValidationException;

import br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.WidgetInfo;

import br.org.groupwareworkbench.tests.DatabaseTester;
import br.org.groupwareworkbench.tests.GWRunner;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;

@RunWith(GWRunner.class)
public class PhotoControllerTest {

    private static volatile String TEMP_DIR;

    private DatabaseTester db;
    private EntityManager em;
    private Collablet collablet;
    private PhotoController controller;
    private PhotoMgrInstance photoMgr;

    //private Collablet outroCollablet;

    private MockResult result;

    private Photo photo1;
    private Photo photo2;
    private Photo photo3;

    @BeforeClass
    public static void initClass() throws IOException {
        File temp = File.createTempFile("xxxx", "xxxx");
        TEMP_DIR = temp.getAbsolutePath();
        temp.delete();
    }

    @Before
    public void setUp() {
        db = new DatabaseTester();
        em = EntityManagerProvider.getEntityManager();

        result = new MockResult();
        
        HttpServletRequest request = mock(HttpServletRequest.class);
        Converters converters = mock(Converters.class);        
        WidgetInfo widgetInfo = new WidgetInfo(request, converters);
        HttpSession session = mock(HttpSession.class);
        RequestInfo requestInfo = mock(RequestInfo.class);
        controller = new PhotoController(result, new MockValidator(), widgetInfo, session, requestInfo, new SearchOverall(result));

        em.getTransaction().begin();
        collablet = new Collablet("photoMgr" + UUID.randomUUID());
        collablet.setComponentClass(PhotoMgrInstance.class);
        collablet.setProperty("dirImages", TEMP_DIR);
        photoMgr = (PhotoMgrInstance) collablet.getBusinessObject();
        em.persist(collablet);        
        createCollabletTagManager();
        em.getTransaction().commit();

        photo1 = new Photo();
        photo1.setCollablet(collablet);
        photo1.setName("foto Um");
        photo1.setNomeArquivo("fotoum.jpg");
        

        photo2 = new Photo();
        photo2.setCollablet(collablet);
        photo2.setName("foto Dois");
        photo2.setNomeArquivo("fotodois.jpg");


        photo3 = new Photo();
        photo3.setCollablet(collablet);
        photo3.setName("foto Tres");
        photo3.setNomeArquivo("fototres.jpg");
        
    }

    private void createCollabletTagManager() {
        Collablet tagMgr = Collablet.findByName("tagMgr");
        if (tagMgr == null) {
            tagMgr = new Collablet("tagMgr");
            tagMgr.setComponentClass(TagMgrInstance.class);
            tagMgr.save();
        }
        photoMgr.getCollablet().addDependency(tagMgr);
    }

    @After
    public void tearDown() {
        if (db != null) db.close();
    }

    private UploadedFile getImage() {
        return new UploadedFile() {

            @Override
            public String getContentType() {
                throw new UnsupportedOperationException();
            }

            @Override
            public InputStream getFile() {
                try {
                    return PhotoControllerTest.class.getResource("fotoum.jpg").openStream();
                } catch (IOException e) {
                    throw new AssertionError(e);
                }
            }

            @Override
            public String getFileName() {
                return "fotoquatro.jpg";
            }
        };
    }

    private List<String> listErrors(ValidationException e) {
        List<Message> errors = e.getErrors();

        List<String> outMensagens = new ArrayList<String>(errors.size());
        for (Message message : errors) {
            outMensagens.add(message.getMessage());
        }
        return outMensagens;
    }

    @Test
    public void testPhotoSearchWithShortString() {
        photo1.save();
        photo2.save();        
        photo3.save();
        try {
            controller.search(photoMgr, "fo", 1, 20);
//            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());
            Assert.assertEquals(PhotoController.MSG_MIN_3_LETRAS, errors.get(0).getMessage());
        }
    }

    @Test
    public void testPhotoSearchWithLongEnoughString() {
        photo1.save();
        photo2.save();
        String id = UUID.randomUUID().toString(),
                term = "alguma" + id;
        photo3.setName(term);
        photo3.save();
        controller.search(photoMgr, term, 1, 20);
        @SuppressWarnings("unchecked")
        Map<String, List<Photo>> photosResult = (Map<String, List<Photo>>) result.included("photos");
        
        List<Photo> photoResult = photosResult.get("name");
        
        Assert.assertEquals(1, photoResult.size());
        Assert.assertFalse(photoResult.contains(photo1));
        Assert.assertFalse(photoResult.contains(photo2));
        Assert.assertTrue(photoResult.contains(photo3));
    }

    @Test
    public void testAdvancedSearchWithoutAnyFields() {
        photo1.save();
        photo2.save();
        photo3.save();
        try {
            controller.buscaFotoAvancada("", "", "", null, photoMgr);
            Assert.fail();
        } catch (ValidationException e) {
            List<Message> errors = e.getErrors();
            Assert.assertEquals(1, errors.size());
            Assert.assertEquals(PhotoController.MSG_NENHUM_CAMPO_PREENCHIDO, errors.get(0).getMessage());
        }
    }

    @Test
    public void testAdvancedSearchByName() {
        photo1.save();
        photo2.save();
        photo3.setName("alguma coisa");
        photo3.save();
        controller.buscaFotoAvancada("foto    ", "", "", null, photoMgr);

        @SuppressWarnings("unchecked")
        List<Photo> fotosResult = (List<Photo>) result.included("fotos");

        Assert.assertEquals(2, fotosResult.size());
        Assert.assertTrue(fotosResult.contains(photo1));
        Assert.assertTrue(fotosResult.contains(photo2));
        Assert.assertFalse(fotosResult.contains(photo3));
    }

    @Test
    public void testAdvancedSearchByNameUnique() {
        photo1.save();
        photo2.save();
        photo3.setName("alguma");
        photo3.save();
        controller.buscaFotoAvancada("alguma", "", "", null, photoMgr);

        @SuppressWarnings("unchecked")
        List<Photo> fotosResult = (List<Photo>) result.included("fotos");

        Assert.assertEquals(1, fotosResult.size());
        Assert.assertTrue(fotosResult.contains(photo3));
    }

    @Test
    public void testSaveWithoutNameNorImage() {
        Photo quatro = new Photo();
        quatro.setCollablet(collablet);
        quatro.setName("");

        try {
            controller.save(quatro, null, photoMgr);
            Assert.fail();
        } catch (ValidationException e) {
            List<String> outMensagens = listErrors(e);
            Assert.assertTrue(outMensagens.contains(PhotoController.MSG_IMAGEM_OBRIGATORIA));
            Assert.assertEquals(1, outMensagens.size());
        }
    }

    @Test
    public void testSaveWithoutImage() {        
        Photo quatro = new Photo();
        quatro.setCollablet(collablet);
        quatro.setName("foto Quatro");
        quatro.setNomeArquivo("fotoquatro.jpg");

        try {
            controller.save(quatro, null, photoMgr);
            Assert.fail();
        } catch (ValidationException e) {
            List<String> outMensagens = listErrors(e);
            Assert.assertTrue(outMensagens.contains(PhotoController.MSG_IMAGEM_OBRIGATORIA));
            Assert.assertEquals(1, outMensagens.size());
        }
    }

    @Test
    public void testSucessfulSave() {        
        Photo quatro = new Photo();
        quatro.setCollablet(collablet); 
        quatro.setName("foto Quatro");
        quatro.setNomeArquivo("fotoquatro.jpg");
        try {
            controller.save(quatro, getImage(), photoMgr);
        } catch (ValidationException e) {
            List<String> outMensagens = listErrors(e);
            for (String erro : outMensagens) {
                System.err.println(erro);
//                Assert.fail();
            }
        }
    }
}
