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
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.GenericReference;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.framework.Collablet;

@Entity
@Table(name="gw_collab_Album")
public class Album implements Serializable  {

    private static final long serialVersionUID = -6876191440831919034L;
    private static final ObjectDAO<Album, Long> DAO = new ObjectDAO<Album, Long>(Album.class);

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private Collablet collablet;

    private String title;
    
    private Date creationDate;
    
    private Date updateDate;

    @ManyToOne
    private User owner;
    
    @OneToMany
    private List<Photo> photos;

    public Album() {
    }

    /* Operations */
    
    public void save() {
        DAO.save(this);
    }

    public void delete() {
        DAO.delete(this);
    }

    public static Album findById(Long id) {
        return DAO.findById(id);
    }

    public static List<Album> list(Collablet collablet) {
        if (collablet == null) throw new IllegalArgumentException();
        return DAO.query().with("collablet", collablet).list();
    }

    public static Album findByName(String name, Collablet collablet) {
        if (collablet == null) throw new IllegalArgumentException();
        if (name == null) throw new IllegalArgumentException();
        return DAO.query()
                    .with("collablet", collablet)
                    .with("name", name)
                    .find();
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
    

    /* Getters and Setters*/
    
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
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Collablet getCollablet() {
        return collablet;
    }

    public void setCollablet(Collablet collablet) {
        this.collablet = collablet;
    }
    
    
    
   
}
