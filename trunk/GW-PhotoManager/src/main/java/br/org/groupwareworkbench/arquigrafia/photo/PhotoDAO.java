package br.org.groupwareworkbench.arquigrafia.photo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;

import org.apache.commons.io.IOUtils;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.GenericDAO;

public class PhotoDAO extends GenericDAO<Photo> {

    public PhotoDAO() {
        super(Photo.class);
    }

    public void saveImage(InputStream foto, String nome, String pasta) throws IOException {
        File file = new File(pasta, nome);
        file.createNewFile();
        IOUtils.copy(foto, new FileOutputStream(file));
    }

    public void assignToUser(long idPhoto, long idUser) {
        Photo photo = this.findById(idPhoto);
        if (photo == null) return;
        
        EntityManager em = getEntityManager();
        String queryString = "SELECT a FROM " + PhotoAssignment.class.getSimpleName() + " a WHERE a.photo.id = :idPhoto AND a.user.id = :idUser";
        TypedQuery<PhotoAssignment> query = em.createQuery(queryString, PhotoAssignment.class);
        query.setParameter("idPhoto", idPhoto);
        query.setParameter("idUser", idUser);
        
        try {
            query.getSingleResult();
        } catch (NoResultException e) {
            PhotoAssignment assignment = new PhotoAssignment();
            User user = em.find(User.class, idUser);

            assignment.setPhoto(photo);
            assignment.setUser(user);

            em.getTransaction().begin();
            em.merge(assignment);
            em.getTransaction().commit();
        }
    }
    
    public File getImageFile(String pasta, String prefix, String nomeArquivoUnico) {
        String path= pasta + prefix + nomeArquivoUnico;
        return new File(path);
    }
    
    public List<Photo> busca(String busca) {
        String query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE UPPER(p.nome) LIKE :nome";
        TypedQuery<Photo> consulta = getEntityManager().createQuery(query, Photo.class);
        consulta.setParameter("nome", "%" + busca.toUpperCase() + "%");
        //consulta.setParameter("lugar", "%"+busca.toUpperCase()+"%");
        //consulta.setParameter("descricao", "%"+busca.toUpperCase()+"%");
        return consulta.getResultList();
    }

    public List<Photo> busca(String nome, String lugar, String descricao, Date date) {
        String query;
        TypedQuery<Photo> consulta;
        if (date == null) {
            query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE (UPPER(p.nome) LIKE :nome AND UPPER(p.lugar) LIKE :lugar AND UPPER(p.descricao) LIKE :descricao)";
            consulta = getEntityManager().createQuery(query, Photo.class);
        } else {
            query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE (UPPER(p.nome) LIKE :nome AND UPPER(p.lugar) LIKE :lugar AND UPPER(p.descricao) LIKE :descricao AND p.data = :date)";
            consulta = getEntityManager().createQuery(query, Photo.class);
            consulta.setParameter("date", date);
        }
        consulta.setParameter("nome", "%" + nome.toUpperCase() + "%");
        consulta.setParameter("lugar", "%" + lugar.toUpperCase() + "%");
        consulta.setParameter("descricao", "%" + descricao.toUpperCase() + "%");
        return consulta.getResultList();
    }

    /*
     * Returns the n-th page of photos with size: pageSize
     * @param pageSize the size of the page (page = 10, 100 elements), pageSize >=0
     * @param pageNumber the number of the page, pageNumber >= 0
     */
    public List<Photo> listPhotoByPage(int pageSize, int pageNumber) {
        String querySentence = "SELECT p FROM " + Photo.class.getSimpleName() + " p";
        TypedQuery<Photo> query = getEntityManager().createQuery(querySentence, Photo.class);
        int firstElement = pageNumber * pageSize;
        query.setFirstResult(firstElement);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public List<Photo> listPhotoByPageAndOrder(int pageSize, int pageNumber) {
        String querySentence = "SELECT p FROM " + Photo.class.getSimpleName() + " p ORDER BY p.dataCriacao DESC";
        TypedQuery<Photo> query = getEntityManager().createQuery(querySentence, Photo.class);
        int firstElement = pageNumber * pageSize;
        query.setFirstResult(firstElement);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }
}
