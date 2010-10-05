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
package br.org.groupwareworkbench.collablet.coop.album;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.coord.friends.Friends;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.framework.Collablet;
import javax.persistence.JoinColumn;

@Entity
@Table(
        name = "gw_collab_Album",
        uniqueConstraints={@UniqueConstraint(columnNames={"collablet_id", "title"})}
)
public class Album implements Serializable {

    private static final long serialVersionUID = -6876191440831919034L;

    private static final ObjectDAO<Album, Long> DAO = new ObjectDAO<Album, Long>(Album.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name="collablet_id")
    private Collablet collablet;

    private String title;

    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;

    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDate;

    @ManyToOne
    private User owner;

    @OneToMany
    private List<Photo> photos = new ArrayList<Photo>();

    public Album() {
    }

    /* Operations */

    public void save() {
        DAO.save(this);
    }

    public void delete() {
        DAO.delete(this);
    }

    public boolean contains(Photo photo) {
        if (photo == null) throw new IllegalArgumentException();
        return this.photos.contains(photo);
    }

    public static Album findById(Long id) {
        return DAO.findById(id);
    }

    public static List<Album> list(Collablet collablet) {
        if (collablet == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).list();
    }
    
    public static List<Album> listByUser(User user, Collablet collablet) {
        if (user == null) throw new IllegalArgumentException("User is required.");
        if (collablet == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).with("owner.id", user.getId()).list();        
    }

    public static Album findByName(String name, Collablet collablet) {
        if (collablet == null) throw new IllegalArgumentException();
        if (name == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).with("name", name).find();
    }

    // Add photos
    public void add(Photo photo) {
        if (photo == null) throw new IllegalArgumentException();
        this.photos.add(photo);
    }

    // Delete photos
    public void remove(Photo photo) {
        if (photo == null) throw new IllegalArgumentException();
        this.photos.remove(photo);
    }

    // List the last photos

    // Sort photos

    /* Getters and Setters */

    public Long getId() {
        return id;
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

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate == null ? null : (Date) creationDate.clone();
    }

    public Date getUpdateDate() {
        return updateDate == null ? null : (Date) updateDate.clone();
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate == null ? null : (Date) updateDate.clone();
    }

    public List<Photo> getPhotos() {
        return Collections.unmodifiableList(this.photos);
    }

    public Collablet getCollablet() {
        return collablet;
    }

    public void setCollablet(Collablet collablet) {
        this.collablet = collablet;
    }

    public int getSize() {
        return this.photos.size();
    }

    
}
