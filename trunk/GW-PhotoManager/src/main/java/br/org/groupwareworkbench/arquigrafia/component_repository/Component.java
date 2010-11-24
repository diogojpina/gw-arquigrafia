package br.org.groupwareworkbench.arquigrafia.component_repository;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import br.org.groupwareworkbench.core.bd.ObjectDAO;

@Entity
public class Component implements Serializable {
    private static final long serialVersionUID = -5500518215313630383L;
    
    private static final ObjectDAO<Component, Long> DAO = new ObjectDAO<Component, Long>(Component.class);

    @Id
	@GeneratedValue
	private long id;
	
	@Column(length=50, nullable=false)
	private String name;
	
	@Column(length=255)
	private String description;
	
	@Column(length=255, nullable=false)
	private String action;
	
	@Column(length=255, nullable=false)
	private String packageName;
	
	@Column(length=10)
	private String version;
	
	@Column(length=32, nullable=false)
	private String md5hash;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date insertionDate;
	
	private long size;
	
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String desc) {
		this.description = desc;
	}
	
	public String getPackageName() {
        return packageName;
    }
    
    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }
	
	public String getAction(){
	    return action;
	}
	
	public void setAction(String action){
	    this.action = action;
	}
	
	public String getVersion() {
		return version;
	}
	
	public void setVersion(String version) {
		this.version = version;
	}
	
	public String getMd5hash() {
		return md5hash;
	}

	public void setMd5hash(String md5hash) {
		this.md5hash = md5hash;
	}

	public Date getInsertionDate() {
		return insertionDate;
	}

	public void setInsertionDate(Date insertionDate) {
		this.insertionDate = insertionDate;
	}

	public Long getSize() {
		return size;
	}
	
	public void setSize(Long size) {
		this.size = size;
	}
	
	public void save(){
        DAO.save(this);
    }
    
    public void delete(){
        DAO.delete(this);
    }
    
    public static Component find(long id) 
    {
        return DAO.findById(id);
    }
    
    public static Component findByMd5hash(String md5hash){
        return DAO.findByField("md5hash", md5hash);
    }
}
