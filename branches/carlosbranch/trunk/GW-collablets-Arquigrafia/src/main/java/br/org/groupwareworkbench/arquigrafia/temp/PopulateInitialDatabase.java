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
package br.org.groupwareworkbench.arquigrafia.temp;

import br.org.groupwareworkbench.collablet.coop.binomial.Binomial;
import br.org.groupwareworkbench.collablet.coop.binomial.BinomialObjects;
import br.org.groupwareworkbench.collablet.coord.role.Role;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.session.GWSecurityRole;

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
            for (Binomial b : BinomialObjects.makeBinomialList(Collablet.findByName("binomialMgr"))) {
                em.persist(b);
            }
            tx.commit();
        } finally {
            if (tx.isActive()) tx.rollback();
        }
    }

    public static void doIt() {
        Collablet role = Collablet.findByName("roleMgr");
        Collablet user = Collablet.findByName("userMgr");

        Role adminRole = new Role();
        adminRole.setName("Administrador");
        adminRole.setCollablet(role);
        // adminRole.addGWSecurityRole(GWSecurityRole.findByCode("ROLE_ADMIN"));
        adminRole.setGWSecurityRoles(GWSecurityRole.listAll());

        Role userRole = new Role();
        userRole.setName("Usuário");
        userRole.setCollablet(role);

        Role orkutRole = new Role();
        orkutRole.setName("Orkut-User");
        orkutRole.setCollablet(role);

        Role facebookRole = new Role();
        facebookRole.setName("Facebook-User");
        facebookRole.setCollablet(role);

        Role twitterRole = new Role();
        twitterRole.setName("Twitter-User");
        twitterRole.setCollablet(role);

        User admin = new User();
        admin.setLogin("admin");
        admin.setEmail("admin@website.com");
        admin.setName("Administrador");
        admin.setPassword("123");
        admin.setCollablet(user);
        admin.assign(adminRole);

        User user01 = new User();
        user01.setLogin("user01");
        user01.setEmail("user01@website.com");
        user01.setName("Usuario01");
        user01.setPassword("111");
        user01.setCollablet(user);
        user01.assign(userRole);

        User user02 = new User();
        user02.setLogin("user02");
        user02.setEmail("user02@website.com");
        user02.setName("Usuario02");
        user02.setPassword("222");
        user02.setCollablet(user);
        user02.assign(userRole);

        insertAll(adminRole, userRole, orkutRole, facebookRole, twitterRole,  admin, user01, user02);
    }
}
