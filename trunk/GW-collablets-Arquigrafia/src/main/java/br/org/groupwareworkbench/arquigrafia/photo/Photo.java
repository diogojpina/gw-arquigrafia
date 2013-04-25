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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Query;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.TypedQuery;

import org.apache.log4j.Logger;
import org.hibernate.annotations.TypeDef;
import org.hibernate.annotations.TypeDefs;

import br.com.caelum.vraptor.interceptor.download.FileDownload;
import br.org.groupwareworkbench.arquigrafia.license.CreativeCommons_3_0;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.bd.QueryBuilder;
import br.org.groupwareworkbench.core.date.ISO8601;
import br.org.groupwareworkbench.core.date.jpa.ISO8601Type;
import br.org.groupwareworkbench.core.date.translation.ISO8601TranslatorFactory;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.graphics.BatchImageProcessor;
import br.org.groupwareworkbench.core.graphics.GraphicalResource;
import br.org.groupwareworkbench.core.graphics.GraphicalResourceSuffix;
import br.org.groupwareworkbench.core.util.Pagination;


@Entity
@Access(AccessType.FIELD)
@TypeDefs(@TypeDef(
        name = "iso8601",
        defaultForType = ISO8601.class,
        typeClass = ISO8601Type.class
     )
)
public class Photo implements Serializable, GraphicalResource {

    ////////////////////////////////////////
    //
    // NON-STATIC SECTION
    //
    ////////////////////////////////////////
    
    //FIXME Extract this enum to top level (not inside of a class) and move it to the license package.
    public enum AllowModifications {  
        YES("Sim",""),
        YES_SA("Sim, contanto que os outros compartilhem de forma semelhante", "-sa"), 
        NO("Não", "-nd");  
      
        private final String name;
        private final String abrev;
      
        AllowModifications(String name, String abrev) {  
            this.name = name;
            this.abrev = abrev;
        }  
      
        public String getName() {  
            return name;  
        }
        
        public String getAbrev() {
            return abrev;
        }

        public AllowModifications getDefault(){
            return YES;
        }
        
    } 
    
    public enum AllowCommercialUses {  
        YES("Sim",""), NO("Não","-nc");  
      
        private final String name; 
        private final String abrev;
      
        AllowCommercialUses(String name, String abrev) {  
            this.name = name;  
            this.abrev = abrev;
        }  

        public String getAbrev() {
            return abrev;
        }
        
        public String getName() {  
            return name;  
        }  
        
        public AllowCommercialUses getDefault(){
            return YES;
        }
        
    } 
    
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

//    @Temporal(TemporalType.DATE)
//    private Date dataCriacao;
    private ISO8601 dataCriacao;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataUpload;

    private String city;
    private String state;
    private String country;
    private String district;
    private String workAuthor;
//    private String workdate;
    private ISO8601 workdate;
    private String street;
    private String description;
    private String collection;
    private String imageAuthor;
    private String aditionalImageComments;
    private String characterization;
    private String tombo;
    private boolean deleted;
    
    @Enumerated(EnumType.STRING)
    private AllowModifications allowModifications;
    
    @Enumerated(EnumType.STRING)
    private AllowCommercialUses allowCommercialUses;
    
//    @Temporal(TemporalType.DATE)
//    private Date cataloguingTime;
    private ISO8601 cataloguingTime;

    // FIXME: ManyToMany!? Por quê? Aliás, esta lista não é usada nunca!
    @ManyToMany
    private List<User> users = new LinkedList<User>();

    public Photo() {
    }

    public Photo(Collablet collablet) {
        this.collablet = collablet;
    }

    public void assignUser(User user) {
        if(!users.contains(user)) {
            users.add(user);
        }
    }

    public void deassignUser(User user) {
        users.remove(user);
    }

    public void delete() {
        DAO.delete(this);
    }

    public void save() {
        this.setDataUpload(Calendar.getInstance().getTime());
        DAO.save(this);
    }

    public void update() {
        DAO.update(this);
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
        return new FileDownload(file, "image/" + DEFAULT_EXTENSION, file.getName());
    }

    public FileDownload downloadImgThumb() {
        return makeDownload("_thumb." + DEFAULT_EXTENSION);
    }

    public FileDownload downloadImgCrop() {
        return makeDownload("_panel." + DEFAULT_EXTENSION);
    }

    public FileDownload downloadImgShow() {
        return makeDownload("_view." + DEFAULT_EXTENSION);
    }

    public FileDownload downloadImgOriginal() {
        String fileExtension = "";
        if(nomeArquivo.contains("."))
            fileExtension = nomeArquivo.substring(nomeArquivo.lastIndexOf("."), nomeArquivo.length());
        return makeDownload(ORIGINAL_FILE_SUFFIX + fileExtension);
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
        
        try {
        
            this.getInstance().getGraphicalResourceManager().saveGraphicaResource(foto, this);
            
            // Creating a string containing the list of image owners
            String owners = "";
            for (User user : users) {
                owners += user.getName() + ", ";
            }
            if (users.size() > 0) {
                owners = owners.substring(0, owners.length()-2);
            }
            
            // Adding metadata to the image set
            Exiv2 imw = new Exiv2(this.getOriginalFileExtension() , this.id, this.getInstance().getDirImages() );
            imw.setAuthor(this.workAuthor);
            imw.setArtist(this.workAuthor, owners);
            imw.setCopyRight(this.imageAuthor, new CreativeCommons_3_0(this.allowCommercialUses, this.allowModifications));
            imw.setDescription(this.description);
            imw.setUserComment(this.aditionalImageComments);
            
        } catch (IOException e) {
            log.error("Error reading image stream", e);
            throw new RuntimeException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
        }
    }

//    private void saveImage(BufferedImage input, String prefix, String path) throws IOException {
//        File photoDirectory = new File(path);
//
//        if (!photoDirectory.exists()) {
//            photoDirectory.mkdir();
//        } else if (photoDirectory.exists() && photoDirectory.isFile()) {
//            photoDirectory.delete();
//            photoDirectory.mkdir();
//        }
//
//        Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("JPG");
//        if (iter.hasNext()) {
//            ImageWriter writer = iter.next();
//            ImageWriteParam iwp = writer.getDefaultWriteParam();
//            iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
//            iwp.setCompressionQuality(0.95f);
//            File outFile = new File(path + File.separator + prefix + id);
//            FileImageOutputStream output = null;
//            try {
//                output = new FileImageOutputStream(outFile);
//                writer.setOutput(output);
//                IIOImage image = new IIOImage(input, null, null);
//                writer.write(null, image, iwp);
//            } finally {
//                if (output != null) output.close();
//            }
//        }
//    }

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

    public ISO8601 getDataCriacao() {
        return dataCriacao;
    }

    public String getDataCriacaoFormatada() {
        try {
            if (dataCriacao == null) return null;
            return ISO8601TranslatorFactory.buildTranslator().translateAndCapitalize(dataCriacao);
        } catch (Exception e) {
            return "";
        }
    }

    public void setDataCriacao(ISO8601 dataCriacao) {
        this.dataCriacao = dataCriacao;
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

    public ISO8601 getWorkdate() {
        return workdate;
    }

    public void setWorkdate(ISO8601 workdate) {
        this.workdate = workdate;
    }

    public String getFormattedWorkdate() {
        try {
            if (workdate == null) return null;
            return ISO8601TranslatorFactory.buildTranslator().translate(workdate);
        } catch (Exception e) {
            return "";
        }
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
    
    public String getCollection() {
        return collection;
    }

    public void setCollection(String collection) {
        this.collection = collection;
    }

    public String getImageAuthor() {
        return imageAuthor;
    }

    public void setImageAuthor(String imageAuthor) {
        this.imageAuthor = imageAuthor;
    }

    public String getAditionalImageComments() {
        return aditionalImageComments;
    }

    public void setAditionalImageComments(String aditionalImageComments) {
        this.aditionalImageComments = aditionalImageComments;
    }

    public String getCharacterization() {
        return characterization;
    }

    public void setCharacterization(String characterization) {
        this.characterization = characterization;
    }

    public String getTombo() {
        return tombo;
    }

    public void setTombo(String tombo) {
        this.tombo = tombo;
    }

    public boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public ISO8601 getCataloguingTime() {
        return cataloguingTime;
    }

    public void setCataloguingTime(ISO8601 cataloguingTime) {
        this.cataloguingTime = cataloguingTime;
    }

    public String getFormattedCataloguingTime() {
        try {
            if (cataloguingTime == null) return null;
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            return sdf.format(cataloguingTime);
        } catch (Exception e) {
            return "";
        }
    }    
    
    public AllowModifications getAllowModifications() {
        return allowModifications;
    }

    public void setAllowModifications(AllowModifications allowModifications) {
        this.allowModifications = allowModifications;
    }

    public AllowCommercialUses getAllowCommercialUses() {
        return allowCommercialUses;
    }

    public void setAllowCommercialUses(AllowCommercialUses allowCommercialUses) {
        this.allowCommercialUses = allowCommercialUses;
    }
    
    @Override
    public String getReferenceIdAsString() {
        return this.id.toString();
    }

    @Override
    public User getUploader() {
        return this.users.get(0);
    }

    @Override
    public String getUploadedFileName() {
        return this.nomeArquivo;
    }

    @Override
    public String getOriginalFileExtension() {
        
        if(nomeArquivo.contains(".") && nomeArquivo.lastIndexOf(".") + 1 < nomeArquivo.length()) {
            return nomeArquivo.substring(nomeArquivo.lastIndexOf(".") + 1, nomeArquivo.length());
        }
        
        return GraphicalResourceSuffix.DEFAULT_EXTENSION;
    }
    
    ////////////////////////////////////////
    //
    // STATIC SECTION
    //
    ////////////////////////////////////////
    
    private static final long serialVersionUID = -4757949223957140519L;
    private static final Integer DEFAULT_PHOTOS_COUNT = 5;
    public static final String ORIGINAL_FILE_SUFFIX = "_original";
    public static final String VIEW_FILE_SUFFIX = "_view";
    public static final String PANEL_FILE_SUFFIX = "_panel";
    public static final String THUMB_FILE_SUFFIX = "_thumb";
    public static final String[] ADDITIONAL_FILE_SUFIXES = new String[] {VIEW_FILE_SUFFIX, PANEL_FILE_SUFFIX, THUMB_FILE_SUFFIX};
    public static final String DEFAULT_EXTENSION = "jpg";
    private static final ObjectDAO<Photo, Long> DAO = new ObjectDAO<Photo, Long>(Photo.class);

    /*
     * public static void deleteAll(Collablet collablet) { DAO.query().with("collablet", collablet).delete(); }
     */

    public static List<Photo> list(Collablet collablet) {
        // TODO Not fully tested.
        Map<String, Object> fields = new HashMap<String, Object>();
        fields.put("collablet", collablet);
        fields.put("deleted", false);
//        return DAO.listByField("collablet", collablet);
        return DAO.listByFields(fields);
    }

    public static Photo findPhotoByUser(User user, long id) {
        if (user == null) throw new IllegalArgumentException();

        String queryString = "SELECT p FROM Photo p JOIN p.users AS u WHERE u = :user AND p.id=id AND p.deleted = false";
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
        query.setParameter("id", id);
        query.setParameter("user", user);
        return query.getResultList().get(0);
    }


    public static List<Photo> listPhotoByUserPageAndOrder(Collablet collablet, User user, int pageSize, int pageNumber) {
        System.out.println("CP5");

        if (collablet == null) throw new IllegalArgumentException();
        if (user == null) throw new IllegalArgumentException();

        int firstElement = pageNumber * pageSize;

        String queryString =
                "SELECT p FROM Photo p JOIN p.users AS u WHERE p.deleted = false AND p.collablet = :collablet AND u = :user ORDER BY p.dataUpload DESC";
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
        query.setMaxResults(pageSize);
        query.setFirstResult(firstElement);
        query.setParameter("collablet", collablet);
        query.setParameter("user", user);
        return query.getResultList();
    }

    public static List<Photo> listPhotosByUser(Collablet collablet, User user) {
        

            if (collablet == null) throw new IllegalArgumentException();
            if (user == null) throw new IllegalArgumentException();

            String queryString =
                    "SELECT p FROM Photo p JOIN p.users AS u WHERE p.deleted = false AND p.collablet = :collablet AND u = :user ORDER BY p.dataUpload DESC";
            EntityManager em = EntityManagerProvider.getEntityManager();
            TypedQuery<Photo> query = em.createQuery(queryString, Photo.class);
            query.setParameter("collablet", collablet);
            query.setParameter("user", user);
            return query.getResultList();


//      if (collablet == null) throw new IllegalArgumentException();
//        if (user == null) throw new IllegalArgumentException();
//        return DAO.query().with("collablet", collablet).with("deleted", false).with("user", user).list();
    }
    
    public static List<Photo> listPhotoByPageAndOrder(Collablet collablet, int pageSize, int pageNumber) {
        System.out.println("CP4");
        if (collablet == null) throw new IllegalArgumentException();

        int firstElement = pageNumber * pageSize;

        return QueryBuilder.query(Photo.class).with("collablet", collablet).with("deleted", false).firstResult(firstElement)
                .maxResults(pageSize).list("dataUpload DESC");
    }
    
    @SuppressWarnings("unchecked")
    public static List<Photo> findByAttribute(Collablet collablet, String fieldName, String value, int page, int perPage) {
        if (SearchTerm.contains(fieldName)) {
            check(value);
            Pagination pagination = new Pagination(page, perPage);
            String queryString = 
                    "select p from Photo p where p.deleted = false AND p.collablet =:collablet AND (" + "upper(p." + fieldName + ") like :nom1 "
                            + "OR upper(p." + fieldName + ") like :nom2 " + "OR upper(p." + fieldName + ") like :nom4 "
                            + "OR upper(p." + fieldName + ") like :nom3 ) order by dataUpload DESC";
            
            EntityManager em = EntityManagerProvider.getEntityManager();
            Query query = em.createQuery(queryString);
    
            return query.setParameter("collablet", collablet)
                        .setParameter("nom1", "%" + value.toUpperCase() + "%")
                        .setParameter("nom2", value.toUpperCase() + "%")
                        .setParameter("nom3", "%" + value.toUpperCase())
                        .setParameter("nom4", value.toUpperCase())
                        .setFirstResult(pagination.firstResult()).setMaxResults(pagination.getPerPage())
                        .getResultList();
        }
        return null;
    }

    private static void check(String value) {
        // FIXME The following line and the code that calls this method need serious review. The following assignment is simply nonsensical.
        if (value.equals("")) value = "!$%--6**24";        
    }
    
    public static Long countByAttribute(Collablet collablet, String fieldName, String value) {
        if (SearchTerm.contains(fieldName) || fieldName.equals("imageAuthor")) {
            check(value);
            String queryString = 
                    "select count(*) from Photo p where p.deleted = false AND p.collablet =:collablet AND (" + "upper(p." + fieldName + ") like :nom1 "
                            + "OR upper(p." + fieldName + ") like :nom2 " + "OR upper(p." + fieldName + ") like :nom4 "
                            + "OR upper(p." + fieldName + ") like :nom3 ) order by dataUpload DESC";
            
            EntityManager em = EntityManagerProvider.getEntityManager();
            Query query = em.createQuery(queryString);
    
            return (Long) query.setParameter("collablet", collablet)
                        .setParameter("nom1", "%" + value.toUpperCase() + "%")
                        .setParameter("nom2", value.toUpperCase() + "%")
                        .setParameter("nom3", "%" + value.toUpperCase())
                        .setParameter("nom4", value.toUpperCase())
                        .getSingleResult();
        }
        return 0l;
    }

    public static List<Photo> busca(Collablet collablet, String name, String city, String description, Date date) {

        if (collablet == null) throw new IllegalArgumentException();
        if (name.equals("")) name = "!$%--6**24";
        if (description.equals("")) description = "!$%--6**24";
        if (city.equals("")) city = "!$%--6**24";
        String queryString =
                "SELECT p FROM Photo p WHERE p.deleted = false AND p.collablet =:collablet AND (" + "(upper(p.name) like :nom1 "
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

    public static Photo findByPhotoNotDeleted(long id) {
        return QueryBuilder.query(Photo.class).with("id", id).with("deleted", false).find();
    }
    
    public static List<Photo> listLastPhotos(Collablet collablet, Integer amount) {
        if (collablet == null) throw new IllegalArgumentException("Collablet is required.");
        Integer localCount = amount;
        if (localCount == null || localCount < 1) {
            localCount = DEFAULT_PHOTOS_COUNT;
        }

        return DAO.query().with("collablet", collablet).with("deleted", false).maxResults(localCount).list("id DESC");

    }

    public static Photo previous(Photo photo) {
        Photo firstPhoto = Photo.first(), previousPhoto = null;
        long currentPhoto = photo.getId();
        while (currentPhoto >= firstPhoto.getId()) {
            currentPhoto = currentPhoto - 1;
            previousPhoto = findByPhotoNotDeleted(currentPhoto);
            if (previousPhoto != null) {
                return previousPhoto;
            }
        }
        
        return previousPhoto;
    }

    public static Photo first() {
        return QueryBuilder.query(Photo.class).with("deleted", false).maxResults(1).find();

    }

    public static Photo next(Photo photo) {
        Long lastPhoto = countAll(), currentPhoto = photo.getId();
        Photo nextPhoto = null;
        while (currentPhoto < lastPhoto) {
            currentPhoto = currentPhoto + 1;
            nextPhoto = findByPhotoNotDeleted(currentPhoto);
            if (nextPhoto != null) {
                return nextPhoto;
            }
        }
        return nextPhoto;
    }

    public static Long countAll() {
        EntityManager em = EntityManagerProvider.getEntityManager();
        Query query = em.createQuery("select count(*) from Photo p");

        return (Long) query.getSingleResult();
    }

    public static Long count() {
        EntityManager em = EntityManagerProvider.getEntityManager();
        Query query = em.createQuery("select count(*) from Photo p where p.deleted = :status");

        return (Long) query.setParameter("status", false).getSingleResult();
    }
    
    public static Photo findByTombo(String tombo) {
        return QueryBuilder.query(Photo.class).with("tombo", tombo).with("deleted", false).find();
    }
}
