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
package br.org.groupwareworkbench.arquigrafia.tracker;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;
import br.org.groupwareworkbench.core.framework.annotations.DefaultProperty;

@ComponentInfo(version = "0.1", 
        configurationURL = "/tracker/{trackerInstance}",
        retrieveURL = "/tracker/{trackerInstance}/list/{lat}/{lng}/{range}",
        defaultProperties = {
                @DefaultProperty(name = "defaultLatitude", defaultValue = "-23.558764"),
                @DefaultProperty(name = "defaultLongitude", defaultValue = "-46.731850"),
                @DefaultProperty(name = "defaultRange", defaultValue = "15")
            }
        )
public class TrackerInstance extends AbstractBusiness {

    private static final String LIST_IN_RANGE_QUERY =
        " SELECT ti " +
        " FROM TrackingInfo ti " +
        " WHERE ti.dateUpdate = ( " +
        "   SELECT MAX(lastTi.dateUpdate) " +
        "   FROM TrackingInfo lastTi " +
        "   WHERE lastTi.user = ti.user " +
        "   GROUP BY lastTi.user " +
        ") AND (:range + ti.accuracy) > (" +
        "   ACOS(SIN(RADIANS(:lat)) * SIN(RADIANS(ti.latitude))" + 
        "   + COS(RADIANS(:lat)) * COS(RADIANS(ti.latitude)) " +
        "   * COS(RADIANS(:lng) - RADIANS(ti.longitude))) * 6378 " +
        " ) AND ti.dateUpdate >= (:dateNowMinus15Minutes) ";

    private static final String COUNT_ONLINE_QUERY =
        " SELECT COUNT(ti) " +
        " FROM TrackingInfo ti " +
        " WHERE ti.dateUpdate = ( " +
        "   SELECT MAX(lastTi.dateUpdate) " +
        "   FROM TrackingInfo lastTi " +
        "   WHERE lastTi.user = ti.user " +
        "   GROUP BY lastTi.user " +
        " ) AND ti.dateUpdate >= (:dateNowMinus15Minutes) ";

    public TrackerInstance(Collablet collablet) {
        super(collablet);
    }

    public void save(TrackingInfo ti) {
        ti.setDateUpdate(new Date());
        ti.setCollablet(getCollablet());
        ti.save();
    }

    //range/accuracy em kilometros
    public List<TrackingInfo> listAllInRange(double latitude, double longitude, double range) {
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<TrackingInfo> q = em.createQuery(LIST_IN_RANGE_QUERY, TrackingInfo.class);
        q.setParameter("lat", latitude);
        q.setParameter("lng", longitude);
        q.setParameter("range", range);
        Calendar nowMinus15 = Calendar.getInstance();
        nowMinus15.add(Calendar.MINUTE, -15);
        q.setParameter("dateNowMinus15Minutes", nowMinus15.getTime());
        return q.getResultList();
    }
    
    public long getOnlineUserCount(){
        EntityManager em = EntityManagerProvider.getEntityManager();
        TypedQuery<Long> q = em.createQuery(COUNT_ONLINE_QUERY, Long.class);
        
        Calendar nowMinus15 = Calendar.getInstance();
        nowMinus15.add(Calendar.MINUTE, -15);
        q.setParameter("dateNowMinus15Minutes", nowMinus15.getTime());
        
        return q.getSingleResult();
    }
}
