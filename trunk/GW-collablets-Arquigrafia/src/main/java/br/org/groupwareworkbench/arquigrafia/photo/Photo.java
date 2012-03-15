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

import java.awt.Dimension;
import java.awt.Point;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.TypedQuery;

import org.apache.log4j.Logger;

import br.com.caelum.vraptor.interceptor.download.FileDownload;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.bd.QueryBuilder;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.graphics.GWImage;
import br.org.groupwareworkbench.core.util.ImageUtils;

@Entity
public class Photo implements Serializable {

    private static final long serialVersionUID = -4757949223957140519L;
    private static final Integer DEFAULT_PHOTOS_COUNT = 5;

    private static final ObjectDAO<Photo, Long> DAO = new ObjectDAO<Photo, Long>(Photo.class);

    @Transient
    private final Logger log = Logger.getLogger(Photo.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private Collablet collablet;

    private transient PhotoMgrInstance instance;

    @Column(name = "name", unique = false, nullable = false)
    private String name;

    @Column(name = "nome_arquivo", unique = false, nullable = false)
    private String nomeArquivo;

    @Temporal(TemporalType.DATE)
    private Date dataCriacao;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUpload;

    private String copyRights;
    private String city;
    private String state;
    private String country;
    private String district;
    private String workAuthor;
    private String workdate;
    private String street;
    private String description;

    // FIXME: ManyToMany!? Por quê? Aliás, esta lista não é usada nunca!
    @ManyToMany
    private List<User> users = new LinkedList<User>();

    public Photo() {
    }

    public Photo(Collablet collablet) {
        this.collablet = collablet;
    }

    public void assignUser(User user) {
        users.add(user);
    }

    public void deassignUser(User user) {
        users.remove(user);
    }

    /*
     * public static void deleteAll(Collablet collablet) { DAO.query().with("collablet", collablet).delete(); }
     */

    public void delete() {
        DAO.delete(this);
    }

    public void save() {
        this.setDataUpload(Calendar.getInstance().getTime());
        DAO.save(this);
    }

    public static List<Photo> list(Collablet collablet) {
        return DAO.listByField("collablet", collablet);
    }

    private PhotoMgrInstance getInstance() {
        if (instance == null) {
            instance = (PhotoMgrInstance) collablet.getBusinessObject();
        }
        return instance;
    }

    private File makeImg(String prefix) {
        String path = getInstance().getDirImages() + id + prefix;
        return new File(path);
    }

    private FileDownload makeDownload(String prefix) {
        File file = makeImg(prefix);
        return new FileDownload(file, "image/jpg", file.getName());
    }

    public FileDownload downloadImgThumb() {
        //return makeDownload(getInstance().getThumbPrefix());
        return makeDownload("_thumb.jpg");
    }

    public FileDownload downloadImgCrop() {
        return makeDownload("_panel.jpg");
    }

    public FileDownload downloadImgShow() {
        return makeDownload("_view.jpg");
    }

    public FileDownload downloadImgOriginal() {
        return makeDownload("_original.jpg");
    }

    public File getImgThumb() {
        return makeImg(getInstance().getThumbPrefix());
    }

    public File getImgCrop() {
        return makeImg(getInstance().getCropPrefix());
    }

    public File getImgShow() {
        return makeImg(getInstance().getMostraPrefix());
    }

    public File getImgOriginal() {
        return makeImg("");
    }

    public void saveImage(InputStream foto) throws RuntimeException {
        
        String imagesDirName = getInstance().getDirImages();
        if(imagesDirName.endsWith(File.separator))
            imagesDirName = imagesDirName.substring(0, imagesDirName.length() - File.separator.length());
        File imagesDir = new File(imagesDirName);
        if(!imagesDir.exists()) {
            System.out.println("Images dir ("  + imagesDirName + ") does not exist. Trying to create it and all nonexistent parents...");
            imagesDir.mkdirs();
            System.out.println("Directory \"" + imagesDirName + "\" created successfully.");
        } else if(!imagesDir.isDirectory()) {
            System.out.println("WTH!? I cannot save images inside of something that is not a directory: " + imagesDirName);
        }
        
        String fileSuffix = "";
        if(nomeArquivo.contains("."))
            fileSuffix = nomeArquivo.substring(nomeArquivo.lastIndexOf("."), nomeArquivo.length());
        String originalFileName = imagesDirName + File.separator + this.id + "_original" + fileSuffix;
        String thumbFileName =  imagesDirName + File.separator + this.id + "_thumb.jpg";
        String panelFileName =  imagesDirName + File.separator + this.id + "_panel.jpg";
        String viewFileName =  imagesDirName + File.separator + this.id + "_view.jpg";
        
        System.out.println("Processing this received file: " + this.nomeArquivo);
        System.out.println("File suffix: " + fileSuffix);
        System.out.println("Saving the original image as " + originalFileName);
        System.out.println("Saving the thumb image as " + thumbFileName);
        System.out.println("Saving the panel image as " + panelFileName);
        System.out.println("Saving the view image as " + viewFileName);
        
        try {
            File originalCopy = new File(originalFileName);
            FileOutputStream fos = new FileOutputStream(originalCopy);
            byte[] buffer;
            while(foto.available()>0) {
                // Using a buffer at most 100kB in size.
                buffer = new byte[Math.min(foto.available(), 1024*100)];
                foto.read(buffer);
                fos.write(buffer);
                fos.flush();
            }
            fos.close();
            foto.close();
            
            try {
                // We need to blur the image to get a better zoom out. Not applying blur before causes the
                // resulting image to have aliases.
                new GWImage(originalCopy).blur(15).doTheBestYouCanToFitOnRectangle(105, 72).save(thumbFileName);
                new GWImage(originalCopy).blur(7).doTheBestYouCanToFitOnRectangle(170, 117).save(panelFileName);
                if(new GWImage(originalCopy).getWidth() > 600)
                    new GWImage(originalCopy).scaleToWidth(600).save(viewFileName);
                else
                    new GWImage(originalCopy).save(viewFileName);
            }
            catch (Throwable t) {
                t.printStackTrace();
            }
            
        } catch (IOException e) {
            log.error("Error reading image stream", e);
            throw new RuntimeException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
        }
        
///////////////////////////////////////////////////////////////
//        BufferedImage imagemOriginal = null;
//        BufferedImage imagemThumb = null;
//        BufferedImage imagemCropped = null;
//        BufferedImage imagemMostra = null;
//
//        try {
//            imagemOriginal = ImageIO.read(foto);
//        } catch (IOException e) {
//            log.error("Error reading image stream", e);
//            throw new RuntimeException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
//        }
//
//        if (imagemOriginal == null) {
//            throw new RuntimeException(PhotoController.MSG_IMAGEM_INVALIDA);
//        }
//
//        try {
//            // Fix wrong colors in PNG to JPEG conversion when PNG has alpha channel
//            imagemOriginal = ImageUtils.createStandardImage(imagemOriginal.getWidth(), imagemOriginal);
//            imagemMostra = ImageUtils.createStandardImage(600, imagemOriginal);
//            imagemThumb = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, true);
//            BufferedImage imagemThumb2 = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, false);
//            Point cropPoint = ImageUtils.calcSqrThumbCropPoint(imagemThumb2);
//            imagemCropped = ImageUtils.cropImage(cropPoint, new Dimension(100, 100), imagemThumb2);
//        } catch (IOException e) {
//            log.error(PhotoController.MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR, e);
//            throw new RuntimeException(PhotoController.MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR, e);
//        }
//
//        try {
//            this.saveImage(imagemOriginal, "", getInstance().getDirImages());
//            this.saveImage(imagemCropped, getInstance().getCropPrefix(), getInstance().getDirImages());
//            this.saveImage(imagemThumb, getInstance().getThumbPrefix(), getInstance().getDirImages());
//            this.saveImage(imagemMostra, getInstance().getMostraPrefix(), getInstance().getDirImages());
//        } catch (IOException e) {
//            log.error(PhotoController.MSG_FALHA_NO_UPLOAD, e);
//            throw new RuntimeException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
//        }
    }

    private void saveImage(BufferedImage input, String prefix, String path) throws IOException {
        File photoDirectory = new File(path);

        if (!photoDirectory.exists()) {
            photoDirectory.mkdir();
        } else if (photoDirectory.exists() && photoDirectory.isFile()) {
            photoDirectory.delete();
            photoDirectory.mkdir();
        }

        Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("JPG");
        if (iter.hasNext()) {
            ImageWriter writer = iter.next();
            ImageWriteParam iwp = writer.getDefaultWriteParam();
            iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            iwp.setCompressionQuality(0.95f);
            File outFile = new File(path + File.separator + prefix + id);
            FileImageOutputStream output = null;
            try {
                output = new FileImageOutputStream(outFile);
                writer.setOutput(output);
                IIOImage image = new IIOImage(input, null, null);
                writer.write(null, image, iwp);
            } finally {
                if (output != null) output.close();
            }
        }
    }

    public static Photo findPhotoByUser(User user, long id) {
        if (user == null) throw new IllegalArgumentException();

        String queryString = "SELECT p FROM Photo p JOIN p.users AS u WHERE u = :user AND p.id=id";
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
        query.setParameter("id", id);
        query.setParameter("user", user);
        return query.getResultList().get(0);
    }

    public static List<Photo> listPhotoByUserPageAndOrder(Collablet collablet, User user, int pageSize, int pageNumber) {
        if (collablet == null) throw new IllegalArgumentException();
        if (user == null) throw new IllegalArgumentException();

        int firstElement = pageNumber * pageSize;

        String queryString =
                "SELECT p FROM Photo p JOIN p.users AS u WHERE p.collablet = :collablet AND u = :user ORDER BY p.dataUpload DESC";
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
        query.setMaxResults(pageSize);
        query.setFirstResult(firstElement);
        query.setParameter("collablet", collablet);
        query.setParameter("user", user);
        return query.getResultList();
    }

    public static List<Photo> listPhotoByPageAndOrder(Collablet collablet, int pageSize, int pageNumber) {
        if (collablet == null) throw new IllegalArgumentException();

        int firstElement = pageNumber * pageSize;

        return QueryBuilder.query(Photo.class).with("collablet", collablet).firstResult(firstElement)
                .maxResults(pageSize).list("dataUpload DESC");
    }

    public static List<Photo> busca(Collablet collablet, String name, String city, String description, Date date) {
        if (collablet == null) throw new IllegalArgumentException();
        if (name.equals("")) name = "!$%--6**24";
        if (description.equals("")) description = "!$%--6**24";
        if (city.equals("")) city = "!$%--6**24";
        String queryString =
                "SELECT p FROM Photo p WHERE p.collablet =:collablet AND (" + "(upper(p.name) like :nom1 "
                        + "OR upper(p.name) like :nom2 " + "OR upper(p.name) like :nom4 "
                        + "OR upper(p.name) like :nom3 )" +

                        "OR (" +

                        "upper(p.description) like :des1 " + "OR upper(p.description) like :des2 "
                        + "OR upper(p.description) like :des4 " + "OR upper(p.description) like :des3 )" +

                        "OR (" +

                        "upper(p.city) like :cid1 " + "OR upper(p.city) like :cid2 "
                        + "OR upper(p.city) like :cid4 " + "OR upper(p.city) like :cid3 )" + "OR "
                        + "p.dataCriacao = :dataCriacao )";

        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
        query.setParameter("collablet", collablet);

        query.setParameter("nom1", "% " + name.toUpperCase() + " %");
        query.setParameter("nom2", name.toUpperCase() + " %");
        query.setParameter("nom3", "% " + name.toUpperCase());
        query.setParameter("nom4", name.toUpperCase());

        query.setParameter("des1", "% " + description.toUpperCase() + " %");
        query.setParameter("des2", description.toUpperCase() + " %");
        query.setParameter("des3", "% " + description.toUpperCase());
        query.setParameter("des4", description.toUpperCase());

        query.setParameter("cid1", "% " + city.toUpperCase() + " %");
        query.setParameter("cid2", city.toUpperCase() + " %");
        query.setParameter("cid3", "% " + city.toUpperCase());
        query.setParameter("cid4", city.toUpperCase());

        query.setParameter("dataCriacao", date);
        return query.getResultList();
    }

    public static Photo findById(long id) {
        return DAO.findById(id);
    }

    public String getNomeArquivo() {
        return nomeArquivo;
    }

    public void setNomeArquivo(String nomeArquivo) {
        this.nomeArquivo = nomeArquivo;
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof Photo)) return false;
        Photo other = (Photo) o;
        return (id == null ? other.id == null : id.equals(other.id)) &&
                (name == null ? other.name == null : name.equals(other.name));
    }

    @Override
    public int hashCode() {
        return (id == null ? 0 : id.hashCode()) ^ (name == null ? 0 : name.hashCode());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDataCriacao() {
        return dataCriacao == null ? null : (Date) dataCriacao.clone();
    }

    public String getDataCriacaoFormatada() {
        if (dataCriacao == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return sdf.format(dataCriacao);
    }

    public void setDataCriacao(Date dataCriacao) {
        this.dataCriacao = dataCriacao == null ? null : (Date) dataCriacao.clone();
    }

    public Date getDataUpload() {
        return dataUpload == null ? null : (Date) dataUpload.clone();
    }

    public void setDataUpload(Date dataUpload) {
        this.dataUpload = dataUpload == null ? null : (Date) dataUpload.clone();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Collablet getCollablet() {
        return collablet;
    }

    public void setCollablet(Collablet collablet) {
        this.collablet = collablet;
    }

    public String getCopyRights() {
        return copyRights;
    }

    public void setCopyRights(String copyRights) {
        this.copyRights = copyRights;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String estate) {
        this.state = estate;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWorkAuthor() {
        return workAuthor;
    }

    public void setWorkAuthor(String workAuthor) {
        this.workAuthor = workAuthor;
    }

    public String getWorkdate() {
        return workdate;
    }

    public void setWorkdate(String workdate) {
        this.workdate = workdate;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public List<User> getUsers() {
        return users;
    }

    public static List<Photo> listLastPhotos(Collablet collablet, Integer amount) {

        if (collablet == null) throw new IllegalArgumentException("Collablet is required.");
        Integer localCount = amount;
        if (localCount == null || localCount < 1) {
            localCount = DEFAULT_PHOTOS_COUNT;
        }

        return DAO.query().with("collablet", collablet).maxResults(localCount).list("id DESC");

    }

}
