package br.org.groupwareworkbench.arquigrafia.photo;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
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
import javax.persistence.TypedQuery;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.bd.QueryBuilder;
import br.org.groupwareworkbench.core.framework.Collablet;

@Entity
public class Photo implements Serializable {

    private static final long serialVersionUID = -4757949223957140519L;

    private static final ObjectDAO<Photo, Long> DAO = new ObjectDAO<Photo, Long>(Photo.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private Collablet collablet;

    @Column(name = "nome", unique = false, nullable = false)
    private String nome;

    @Column(name = "nome_arquivo", unique = false, nullable = false)
    private String nomeArquivo;

    private String descricao;

    private String lugar;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCriacao;

    @ManyToMany
    private List<User> users = new LinkedList<User>();

    public Photo() {
    }

    public Photo(Collablet collablet) {
        this.collablet = collablet;
    }

    public void assignUser(User user) {
        users.add(user);
        DAO.update(this);
    }

    public void deassignUser(User user) {
        users.remove(user);
        DAO.update(this);
    }

    public static void deleteAll(Collablet collablet) {
        DAO.query().with("collablet", collablet).delete();
    }

    public void delete() {
        DAO.delete(this);
    }

    public void save() {
        DAO.save(this);
    }

    public static List<Photo> list(Collablet collablet) {
        return DAO.listByField("collablet", collablet);
    }

    public static File getImageFile(String pasta, String prefix, String nomeArquivoUnico) {
        String path = pasta + prefix + nomeArquivoUnico;
        return new File(path);
    }

    public static void saveImage(BufferedImage input, String name, String path) throws IOException {
        File photoDirectory = new File(path);
        if (!photoDirectory.exists()) {
            photoDirectory.mkdir();
        }

        Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("JPG");
        if (iter.hasNext()) {
            ImageWriter writer = iter.next();
            ImageWriteParam iwp = writer.getDefaultWriteParam();
            iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            iwp.setCompressionQuality(0.95f);
            File outFile = new File(path + File.separator + name);
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

    public static List<Photo> listPhotoByPageAndOrder(Collablet collablet, int pageSize, int pageNumber) {
        EntityManager em = EntityManagerProvider.getEntityManager();
        String querySentence =
                "SELECT p FROM " + Photo.class.getSimpleName() +
                        " p WHERE p.collablet=:collablet ORDER BY p.dataCriacao DESC";
        TypedQuery<Photo> query = em.createQuery(querySentence, Photo.class);
        query.setParameter("collablet", collablet);
        int firstElement = pageNumber * pageSize;
        query.setFirstResult(firstElement);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }

    public static List<Photo> busca(Collablet collablet, String nome, String lugar, String descricao, Date date) {
        if (collablet == null) throw new IllegalArgumentException();

        QueryBuilder q = QueryBuilder.query(Photo.class)
                .with("collablet", collablet);

        if (nome != null) q.with("nome", "%" + nome.toUpperCase() + "%").upper().like();
        if (descricao != null) q.with("descricao", "%" + descricao.toUpperCase() + "%").upper().like();
        if (lugar != null) q.with("lugar", "%" + lugar.toUpperCase() + "%").upper().like();
        if (date != null) q.with("dataCriacao", date);

        return q.list();
    }

    public static Photo findById(long id) {
        return DAO.findById(id);
    }

    public String getNomeArquivoUnico() {
        return this.getId() + this.getNomeArquivo();
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
                (nome == null ? other.nome == null : nome.equals(other.nome));
    }

    @Override
    public int hashCode() {
        return (id == null ? 0 : id.hashCode()) ^
                (nome == null ? 0 : nome.hashCode());
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
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
        this.dataCriacao = (dataCriacao == null ? null : (Date) dataCriacao.clone());
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
}
