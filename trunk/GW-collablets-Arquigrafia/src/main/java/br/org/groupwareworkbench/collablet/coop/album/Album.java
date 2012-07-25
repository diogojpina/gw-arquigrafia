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
package br.org.groupwareworkbench.collablet.coop.album;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.GenericReference;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.framework.Collablet;

@Entity
@Table(name = "gw_collab_Album")
public class Album implements Serializable {

    private static final long serialVersionUID = -6876191440831919034L;

    private static final ObjectDAO<Album, Long> DAO = new ObjectDAO<Album, Long>(Album.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "collablet_id")
    private Collablet collablet;

    private String title;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    private String description;

    @ManyToOne
    private User owner;

    private String urlCover;

    @ElementCollection
    @CollectionTable(name = "gw_collab_Album_Elements")
    private List<GenericReference> objects = new ArrayList<GenericReference>();

    public Album() {
    }

    /* Operations */

    public void save() {
        this.setCreationDate(Calendar.getInstance().getTime());
        DAO.save(this);
    }

    public void update() {
        DAO.update(this);
    }

    public void delete() {
        DAO.delete(this);
    }

    public boolean contains(Object object) {
        if (object == null) throw new IllegalArgumentException();
        return this.objects.contains(new GenericReference(object));
    }

    public static Album findById(Long id) {
        Album album = null;
        if (id == null) {
            album = new Album();
            return album;
        }
        album = DAO.findById(id);
        if (album == null) {
            album = new Album();
        }
        return album;
    }

    public static List<Album> listByUser(User user, Collablet collablet) {
        if (user == null) throw new IllegalArgumentException("User is required.");
        if (collablet == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).with("owner.id", user.getId()).list();
    }

    public static List<Album> limitListByUser(User user, Collablet collablet) {
        if (user == null) throw new IllegalArgumentException("User is required.");
        if (collablet == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).with("owner.id", user.getId()).maxResults(6).list();
    }

    public void add(Object object) {
        if (object == null) throw new IllegalArgumentException();
        GenericReference reference = new GenericReference(object);
        if (!this.objects.contains(reference))
            this.objects.add(new GenericReference(object));
    }
    
    public void remove(Object object) {
        if (object == null) throw new IllegalArgumentException();
        this.objects.remove(new GenericReference(object));
    }

    /* Getters and Setters */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreationDate() {
        return creationDate == null ? null : (Date) creationDate.clone();
    }

    public String getFormattedCreationDate() {
        if (creationDate == null) return null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        return sdf.format(creationDate);
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate == null ? null : (Date) creationDate.clone();
    }

    public List<Object> getObjects() {
        List<Object> result = new ArrayList<Object>(objects.size());
        for (GenericReference gr : this.objects) {
            result.add(gr.getEntity());
        }
        return Collections.unmodifiableList(result);
    }

    public Collablet getCollablet() {
        return collablet;
    }

    public void setCollablet(Collablet collablet) {
        this.collablet = collablet;
    }

    public int getSize() {
        return this.objects.size();
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public User getOwner() {
        return owner;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setUrlCover(String urlCover) {
        this.urlCover = urlCover;
    }

    public String getUrlCover() {
        return urlCover;
    }
}
