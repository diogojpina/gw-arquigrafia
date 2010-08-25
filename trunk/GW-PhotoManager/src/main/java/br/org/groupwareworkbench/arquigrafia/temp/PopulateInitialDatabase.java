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
package br.org.groupwareworkbench.arquigrafia.temp;

import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;
import br.org.groupwareworkbench.collablet.communic.comment.CommentMgrInstance;
import br.org.groupwareworkbench.collablet.communic.googlemapsmarker.GoogleMapsMarkerMgrInstance;
import br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance;
import br.org.groupwareworkbench.collablet.communic.upload.UploadMgrInstance;
import br.org.groupwareworkbench.collablet.coop.binomial.BinomialMgrInstance;
import br.org.groupwareworkbench.collablet.coop.rating.RatingMgrInstance;
import br.org.groupwareworkbench.collablet.coord.category.Category;
import br.org.groupwareworkbench.collablet.coord.category.CategoryMgrInstance;
import br.org.groupwareworkbench.collablet.coord.collabletmanagement.CollabletMgrInstance;
import br.org.groupwareworkbench.collablet.coord.profile.ProfileMgrInstance;
import br.org.groupwareworkbench.collablet.coord.role.Role;
import br.org.groupwareworkbench.collablet.coord.role.RoleAssignment;
import br.org.groupwareworkbench.collablet.coord.role.RoleMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.UserMgrInstance;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.exceptions.ConfigurationException;
import br.org.groupwareworkbench.core.framework.Business;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.MainCollablet;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;

// CODIGO TEMPORÁRIO!
public class PopulateInitialDatabase {

    private static void insertAll(Object... toSave) {
        EntityManager em = EntityManagerProvider.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            for (Object c : toSave) {
                em.persist(c);
            }
            tx.commit();
        } finally {
            if (tx.isActive()) tx.rollback();
        }
    }

    private static void saveAll(Collablet... collablets) {
        EntityManager em = EntityManagerProvider.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            for (Collablet c : collablets) {
                if (c.getId() == null) {
                    em.persist(c);
                } else {
                    em.merge(c);
                }
            }
            tx.commit();
        } finally {
            if (tx.isActive()) tx.rollback();
        }
    }

    private static void populate(Collablet c) {
        c.setEnabled(true);
        String full = c.getComponentClassName();
        String instanceLess = full.substring(0, full.length() - "Instance".length());
        String name = instanceLess.substring(instanceLess.lastIndexOf('.') + 1);
        String lowerCaseName = Character.toLowerCase(name.charAt(0)) + name.substring(1);
        c.setName(lowerCaseName);
    }

    public static void doCollablets() {

        if (MainCollablet.wasInitialized()) return;

        Collablet comment = new Collablet();
        comment.setComponentClass(CommentMgrInstance.class);
        comment.setCod("br.org.groupwareworkbench.collablet.communic.Comment");
        comment.setDescription("Gerenciar comentários");
        populate(comment);

        Collablet googlemaps = new Collablet();
        googlemaps.setComponentClass(GoogleMapsMarkerMgrInstance.class);
        googlemaps.setCod("br.org.groupwareworkbench.collablet.communic.GoogleMapsMarker");
        googlemaps.setDescription("Gerenciar Google Maps");
        populate(googlemaps);

        Collablet tag = new Collablet();
        tag.setComponentClass(TagMgrInstance.class);
        tag.setCod("br.org.groupwareworkbench.collablet.communic.Tag");
        tag.setDescription("Gerenciar tags");
        populate(tag);

        /*Collablet upload = new Collablet();
        upload.setComponentClass(UploadMgrInstance.class);
        upload.setCod("br.org.groupwareworkbench.collablet.communic.Upload");
        upload.setDescription("Gerenciar upload");
        populate(upload);*/

        Collablet binomial = new Collablet();
        binomial.setComponentClass(BinomialMgrInstance.class);
        binomial.setCod("br.org.groupwareworkbench.collablet.coop.Binomial");
        binomial.setDescription("Gerenciar binômios");
        populate(binomial);

        Collablet rating = new Collablet();
        rating.setComponentClass(RatingMgrInstance.class);
        rating.setCod("br.org.groupwareworkbench.collablet.coop.Rating");
        rating.setDescription("Gerenciar avaliação");
        populate(rating);

        Collablet profile = new Collablet();
        profile.setComponentClass(ProfileMgrInstance.class);
        profile.setCod("br.org.groupwareworkbench.collablet.coop.Profile");
        populate(profile);

        Collablet role = new Collablet();
        role.setComponentClass(RoleMgrInstance.class);
        role.setCod("br.org.groupwareworkbench.collablet.coord.Role");
        role.setDescription("Gerenciar papéis");
        populate(role);

        Collablet user = new Collablet();
        user.setComponentClass(UserMgrInstance.class);
        user.setCod("br.org.groupwareworkbench.collablet.coord.User");
        user.setDescription("Gerenciar usuários");
        populate(user);
        user.addDependency(role, profile);

        Collablet collab = new Collablet();
        collab.setComponentClass(CollabletMgrInstance.class);
        collab.setCod("br.org.groupwareworkbench.collablet.coord.CollabletManagement");
        collab.setDescription("Gerenciar collablets");
        populate(collab);

        Class<? extends Business> siteInstanceClass;
        try {
            siteInstanceClass = Class.forName("br.org.groupwareworkbench.arquigrafia.site.SiteInstance").asSubclass(Business.class);
        } catch (ClassNotFoundException e) {
            throw new ConfigurationException(e);
        }

        Collablet site = new Collablet();
        site.setComponentClass(siteInstanceClass);
        site.setCod("environment/Default");
        site.setEnabled(true);
        site.setName("Arquigrafia Brasil");
        site.setDescription("---");
        site.addDependency(comment, googlemaps, tag, /*upload,*/ binomial, rating, /*recommend,*/ profile, role, user, collab);

        MainCollablet mc = new MainCollablet();
        mc.setMain(site);

        Collablet collabPhoto = new Collablet();
        collabPhoto.setComponentClass(CollabletMgrInstance.class);
        collabPhoto.setCod("br.org.groupwareworkbench.collablet.coord.CollabletManagement");
        collabPhoto.setDescription("Gerenciar collablets");
        populate(collabPhoto);

        Collablet commentPhoto = new Collablet();
        commentPhoto.setComponentClass(CommentMgrInstance.class);
        commentPhoto.setCod("br.org.groupwareworkbench.collablet.communic.Comment");
        commentPhoto.setDescription("Gerenciar comentários");
        populate(commentPhoto);

        Collablet binomialPhoto = new Collablet();
        binomialPhoto.setComponentClass(BinomialMgrInstance.class);
        binomialPhoto.setCod("br.org.groupwareworkbench.collablet.coop.Binomial");
        binomialPhoto.setDescription("Gerenciar binômios");
        populate(binomialPhoto);

        Collablet ratingPhoto = new Collablet();
        ratingPhoto.setComponentClass(RatingMgrInstance.class);
        ratingPhoto.setCod("br.org.groupwareworkbench.collablet.coop.Rating");
        ratingPhoto.setDescription("Gerenciar avaliação");
        populate(ratingPhoto);

        Collablet photo = new Collablet();
        photo.setComponentClass(PhotoMgrInstance.class);
        photo.setCod("cooperation-collablets/Photo");
        photo.setEnabled(true);
        photo.setName("Registro de fotografias");
        photo.setDescription("---");
        photo.setParent(site);
        photo.addDependency(tag, /*recommendPhoto,*/ commentPhoto, binomialPhoto, ratingPhoto);

        insertAll(comment, googlemaps, tag, /*upload,*/ binomial, rating, /*recommend,*/ profile, role, user, collab, site,
                /*recommendPhoto,*/ commentPhoto, binomialPhoto, ratingPhoto, photo,
                mc);
    }

    public static void doIt() {
        Collablet role = Collablet.findByName("roleMgr");
        Collablet user = Collablet.findByName("userMgr");

        Role adminRole = new Role();
        adminRole.setName("Administrador");
        adminRole.setIdInstance(role.getId());

        Role userRole = new Role();
        userRole.setName("Usuário");
        userRole.setIdInstance(role.getId());

        Role reviewerRole = new Role();
        reviewerRole.setName("Revisor");
        reviewerRole.setIdInstance(role.getId());

        User admin = new User();
        admin.setLogin("admin");
        admin.setEmail("admin@website.com");
        admin.setName("Administrador");
        admin.setPassword("123");
        admin.setIdInstance(user.getId());

        User user01 = new User();
        user01.setLogin("user01");
        user01.setEmail("user01@website.com");
        user01.setName("Usuario01");
        user01.setPassword("111");
        user01.setIdInstance(user.getId());

        User user02 = new User();
        user02.setLogin("user02");
        user02.setEmail("user02@website.com");
        user02.setName("Usuario02");
        user02.setPassword("222");
        user02.setIdInstance(user.getId());

        RoleAssignment assign1 = new RoleAssignment();
        assign1.setRole(adminRole);
        assign1.setGenericEntity(admin);

        RoleAssignment assign2 = new RoleAssignment();
        assign2.setRole(userRole);
        assign2.setGenericEntity(user01);

        RoleAssignment assign3 = new RoleAssignment();
        assign3.setRole(reviewerRole);
        assign3.setGenericEntity(user02);

        insertAll(adminRole, userRole, reviewerRole,
                admin, user01, user02,
                assign1, assign2, assign3);
    }
}
