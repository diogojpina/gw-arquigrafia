/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
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
import java.io.InputStream;
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
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.com.caelum.vraptor.interceptor.download.FileDownload;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.bd.QueryBuilder;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.util.ImageUtils;

@Entity
public class Photo implements Serializable {

    private static final long serialVersionUID = -4757949223957140519L;

    private static final ObjectDAO<Photo, Long> DAO = new ObjectDAO<Photo, Long>(Photo.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private Collablet collablet;

    private transient PhotoMgrInstance instance;

    @Column(name = "nome", unique = false, nullable = false)
    private String nome;

    @Column(name = "nome_arquivo", unique = false, nullable = false)
    private String nomeArquivo;

    private String descricao;

    @Temporal(TemporalType.DATE)
    private Date dataCriacao;
    
    
    private String direitosAutorais;
    private String cidade;
    private String estado;
    private String pais;
    
    private String infArquitetonicas;
    
    

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

    private PhotoMgrInstance getInstance() {
        if (instance == null) {
            instance = (PhotoMgrInstance) collablet.getBusinessObject();
        }
        return instance;
    }

    private File makeImg(String prefix) {
        String path = getInstance().getDirImages() + prefix + id;
        return new File(path);
    }

    private FileDownload makeDownload(String prefix) {
        File file = makeImg(prefix);
        return new FileDownload(file, "image/jpg", file.getName());
    }

    public FileDownload downloadImgThumb() {
        return makeDownload(getInstance().getThumbPrefix());
    }

    public FileDownload downloadImgCrop() {
        return makeDownload(getInstance().getCropPrefix());
    }

    public FileDownload downloadImgShow() {
        return makeDownload(getInstance().getMostraPrefix());
    }

    public FileDownload downloadImgOriginal() {
        return makeDownload("");
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

    public void saveImage(InputStream foto) throws IOException {
        BufferedImage imagemOriginal = null;
        BufferedImage imagemThumb = null;
        BufferedImage imagemCropped = null;
        BufferedImage imagemMostra = null;

        try {
            imagemOriginal = ImageIO.read(foto);
        } catch (IOException e) {
            throw new IOException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
        }

        if (imagemOriginal == null) {
            throw new IOException(PhotoController.MSG_IMAGEM_INVALIDA);
        }

        try {
            imagemMostra = ImageUtils.createThumbnailIfNecessary(800, imagemOriginal, true);
            imagemThumb = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, true);
            BufferedImage imagemThumb2 = ImageUtils.createThumbnailIfNecessary(100, imagemOriginal, false);
            Point cropPoint = ImageUtils.calcSqrThumbCropPoint(imagemThumb2);
            imagemCropped = ImageUtils.cropImage(cropPoint, new Dimension(100, 100), imagemThumb2);
        } catch (IOException e) {
            throw new IOException(PhotoController.MSG_NAO_FOI_POSSIVEL_REDIMENSIONAR, e);
        }

        try {
            this.saveImage(imagemOriginal, "", getInstance().getDirImages());
            this.saveImage(imagemCropped, getInstance().getCropPrefix(), getInstance().getDirImages());
            this.saveImage(imagemThumb, getInstance().getThumbPrefix(), getInstance().getDirImages());
            this.saveImage(imagemMostra, getInstance().getMostraPrefix(), getInstance().getDirImages());
        } catch (IOException e) {
            throw new IOException(PhotoController.MSG_FALHA_NO_UPLOAD, e);
        }
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

    public static List<Photo> listPhotoByPageAndOrder(Collablet collablet, int pageSize, int pageNumber) {
        if (collablet == null) throw new IllegalArgumentException();

        int firstElement = pageNumber * pageSize;

        return QueryBuilder.query(Photo.class)
                .with("collablet", collablet)
                .firstResult(firstElement)
                .maxResults(pageSize)
                .list("dataCriacao DESC");
    }

    public static List<Photo> busca(Collablet collablet, String nome, String lugar, String descricao, Date date) {
        if (collablet == null) throw new IllegalArgumentException();

        QueryBuilder<Photo> q = QueryBuilder.query(Photo.class).with("collablet", collablet);

        if (!nome.isEmpty()) q.with("nome", "%" + nome.toUpperCase() + "%").upper().like();
        if (!descricao.isEmpty()) q.with("descricao", "%" + descricao.toUpperCase() + "%").upper().like();
        if (!lugar.isEmpty()) q.with("lugar", "%" + lugar.toUpperCase() + "%").upper().like();
        if (date != null) q.withDay("dataCriacao", date);

        return q.list();
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
        return (id == null ? other.id == null : id.equals(other.id))
                && (nome == null ? other.nome == null : nome.equals(other.nome));
    }

    @Override
    public int hashCode() {
        return (id == null ? 0 : id.hashCode())
                ^ (nome == null ? 0 : nome.hashCode());
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

    public String getDireitosAutorais() {
        return direitosAutorais;
    }

    public void setDireitosAutorais(String direitosAutorais) {
        this.direitosAutorais = direitosAutorais;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getInfArquitetonicas() {
        return infArquitetonicas;
    }

    public void setInfArquitetonicas(String infArquitetonicas) {
        this.infArquitetonicas = infArquitetonicas;
    }
}
