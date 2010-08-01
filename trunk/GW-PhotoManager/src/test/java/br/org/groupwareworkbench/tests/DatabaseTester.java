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
package br.org.groupwareworkbench.tests;

import br.org.groupwareworkbench.core.bd.DAOFactory;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.Business;
import br.org.groupwareworkbench.core.framework.Collablet;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.mockito.Mockito;

/**
 * @author Victor Williams Stafusa da Silva
 */
public class DatabaseTester {

    private final EntityManagerFactory factory;
    private final EntityManager em;
    private final Map<Class<?>, Object> daos;
    private boolean closed = false;

    public DatabaseTester() {
        factory = Persistence.createEntityManagerFactory("TestUnit");
        em = factory.createEntityManager();
        EntityManagerProvider.setEntityManager(em);

        daos = new HashMap<Class<?>, Object>();
        DAOFactory.setFactory(new DAOFactory() {

            @Override
            protected <T> T make(Class<T> classe) {
                Object obj = daos.get(classe);
                if (obj != null) return classe.cast(obj);
                return super.make(classe);
            }
        });
    }

    public void close() {
        closed = true;
        try {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
        } finally {
            em.close();
            factory.close();
        }
    }

    public <E> void mapDAO(Class<E> theClass, E obj) {
        if (closed) throw new IllegalStateException();
        daos.put(theClass, obj);
    }

    public <E> E mapDAO(Class<E> theClass) {
        if (closed) throw new IllegalStateException();
        E obj = Mockito.mock(theClass);
        daos.put(theClass, obj);
        return obj;
    }

    public Collablet makeCollablet(Class<? extends Business> businessClass) {
        if (closed) throw new IllegalStateException();
        Collablet collablet = new Collablet();
        collablet.setComponentClass(businessClass);
        collablet.setEnabled(true);
        collablet.save();
        return collablet;
    }

    public Collablet makeCollablet(Class<? extends Business> businessClass, String name) {
        if (closed) throw new IllegalStateException();
        Collablet collablet = new Collablet();
        collablet.setComponentClass(businessClass);
        collablet.setEnabled(true);
        collablet.setName(name);
        collablet.save();
        return collablet;
    }

    public <E extends Business> E makeBusinessObject(Class<E> businessClass) {
        return businessClass.cast(makeCollablet(businessClass).getBusinessObject());
    }

    public <E extends Business> E makeBusinessObject(Class<E> businessClass, String name) {
        return businessClass.cast(makeCollablet(businessClass, name).getBusinessObject());
    }

    @Override
    @SuppressWarnings("FinalizeDeclaration")
    protected void finalize() {
        try {
            super.finalize();
        } catch (Throwable t) {
            throw new AssertionError(t);
        }
        if (!closed) System.err.println("PERIGO: O método close() do DatabaseTester não foi chamado corretamente!");
        close();
    }
}
