package br.org.groupware_workbench.photo.internal;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.apache.commons.io.IOUtils;

import br.org.groupware_workbench.commons.bd.jpa.ObjectDAO;
import br.org.groupware_workbench.photo.Photo;

//public class PhotoRegisterDAO extends GenericDAO<PhotoRegister> {
public class PhotoDAO extends ObjectDAO<Photo, Long> {	

    public PhotoDAO() {
        super(Photo.class);
    }

    public void saveImage(InputStream foto, String nome, String pasta) throws IOException {
        File file = new File(pasta, nome);
        file.createNewFile();
        IOUtils.copy(foto, new FileOutputStream(file));
    }

    public List<Photo> buscaPorID(List<Long> photoIDs, Long idInstance) {
        String listAsString = photoIDs.toString();
        String queryText = "Select p FROM " + Photo.class.getSimpleName() + " p WHERE p.idInstance=:idInstance AND p.id IN (" + listAsString + ")";
        Query query = getEntityManager().createQuery(queryText);
        query.setParameter("idInstance", idInstance);

        @SuppressWarnings("unchecked")
        List<Photo> result = (List<Photo>) query.getResultList();

        return result;
    }

    public List<Photo> busca(String busca, Long idInstance) {
        String query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE p.idInstance=:idInstance AND upper(p.nome) LIKE :nome";
        Query consulta = getEntityManager().createQuery(query);
        consulta.setParameter("idInstance", idInstance);
        consulta.setParameter("nome", "%" + busca.toUpperCase() + "%");
        //consulta.setParameter("lugar", "%"+busca.toUpperCase()+"%");
        //consulta.setParameter("descricao", "%"+busca.toUpperCase()+"%");

        @SuppressWarnings("unchecked")
        List<Photo> result = (List<Photo>) consulta.getResultList();

        return result;
    }

    public List<Photo> busca(String nome, String lugar, String descricao, Date date, Long idInstance) {
        String query;
        Query consulta;
        if (date == null) {
            query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE p.idInstance = :idInstance AND (upper(p.nome) LIKE :nome AND upper(p.lugar) LIKE :lugar AND upper(p.descricao) LIKE :descricao)";
            consulta = getEntityManager().createQuery(query);
        } else {
            query = "SELECT p FROM " + Photo.class.getSimpleName() + " p WHERE p.idInstance = :idInstance AND (upper(p.nome) LIKE :nome AND upper(p.lugar) LIKE :lugar AND upper(p.descricao) LIKE :descricao AND p.data = :date)";
            consulta = getEntityManager().createQuery(query);
            consulta.setParameter("date", date);
        }
        consulta.setParameter("idInstance", idInstance);
        consulta.setParameter("nome", "%" + nome.toUpperCase() + "%");
        consulta.setParameter("lugar", "%" + lugar.toUpperCase() + "%");
        consulta.setParameter("descricao", "%" + descricao.toUpperCase() + "%");

        @SuppressWarnings("unchecked")
        List<Photo> result = (List<Photo>) consulta.getResultList();

        return result;
    }

    /*
     * Returns the n-th page of photos with size: pageSize
     * @param pageSize the size of the page (page = 10, 100 elements), pageSize >=0
     * @param pageNumber the number of the page, pageNumber >= 0
     */
    public List<Photo> listPhotoByPage(int pageSize, int pageNumber) {
        String querySentence = "SELECT p FROM " + Photo.class.getSimpleName() + " p";
        Query query = getEntityManager().createQuery(querySentence);
        int firstElement = pageNumber * pageSize;
        query.setFirstResult(firstElement);
        query.setMaxResults(pageSize);

        @SuppressWarnings("unchecked")
        List<Photo> result = (List<Photo>) query.getResultList();

        return result;
    }
    
    public List<Photo> listPhotoByPageAndOrder(int pageSize, int pageNumber) {
        String querySentence = "SELECT p FROM " + Photo.class.getSimpleName() + " p ORDER BY  p.dataCriacao DESC";
        Query query = getEntityManager().createQuery(querySentence);
        int firstElement = pageNumber * pageSize;
        query.setFirstResult(firstElement);
        query.setMaxResults(pageSize);

        @SuppressWarnings("unchecked")
        List<Photo> result = (List<Photo>) query.getResultList();

        return result;
    }
}
