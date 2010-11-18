package br.org.groupwareworkbench.arquigrafia.tracker;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.ObjectDAO;
import br.org.groupwareworkbench.core.framework.Collablet;

@Entity
public class TrackingInfo implements Serializable {
    private static final long serialVersionUID = -7858458259300455392L;
    
    private static final ObjectDAO<TrackingInfo, Long> DAO = new ObjectDAO<TrackingInfo, Long>(TrackingInfo.class);
    
    @Id
	@GeneratedValue
	private long id;

    @ManyToOne
    @JoinColumn(name="collablet_id")
    private Collablet collablet;
    
    @ManyToOne
	private User user;
	
	private double accuracy;
	
	private double latitude;
	
	private double longitude;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date dateUpdate;
	
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	public double getAccuracy() {
		return accuracy;
	}
	
	public void setAccuracy(double accuracy) {
		this.accuracy = accuracy;
	}
	
	public double getLatitude() {
		return latitude;
	}
	
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	
	public double getLongitude() {
		return longitude;
	}
	
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public Date getDateUpdate() {
		return dateUpdate;
	}
	
	public void setDateUpdate(Date dateUpdate) {
		this.dateUpdate = dateUpdate;
	}

    public Collablet getCollablet() {
        return collablet;
    }

    public void setCollablet(Collablet collablet) {
        this.collablet = collablet;
    }

    public void save(){
        DAO.save(this);
    }
    
    public void delete(){
        DAO.delete(this);
    }
    
    public static TrackingInfo find(long id) 
    {
        return DAO.findById(id);
    }
}
