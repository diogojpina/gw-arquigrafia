package br.org.groupware_workbench.site;

import javax.persistence.Column;
import javax.persistence.Entity;

import br.org.groupware_workbench.coreutils.GenericEntity;

@Entity
public class Site extends GenericEntity {

    private static final long serialVersionUID = 3078904680230841278L;

    @Column(name="name", unique=true, nullable=false)
    private String name;

}
