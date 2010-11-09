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
package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import br.org.groupwareworkbench.core.framework.AbstractBusiness;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.framework.annotations.ComponentInfo;
import br.org.groupwareworkbench.core.framework.annotations.DefaultProperty;
import br.org.groupwareworkbench.core.framework.annotations.RequiredProperty;

@ComponentInfo(version = "0.1", 
        configurationURL = "/groupware-workbench/photo/{photoInstance}/index",
        retrieveURL = "/groupware-workbench/photo/{id}",
        defaultProperties = {
            @DefaultProperty(name = "cropPrefix", defaultValue = "crop_"),
            @DefaultProperty(name = "thumbPrefix", defaultValue = "thumb_"),
            @DefaultProperty(name = "mostraPrefix", defaultValue = "mostra_")
        },
        requiredProperties = {@RequiredProperty(name = "dirImages")})
public class PhotoMgrInstance extends AbstractBusiness {

    public PhotoMgrInstance(Collablet collablet) {
        super(collablet);
    }

    public void save(Photo photo) {
        photo.setCollablet(getCollablet());
        photo.save();
    }

    public List<Photo> buscaFoto(String busca) {
        return Photo.busca(getCollablet(), busca, "", "", null);
    }

    public List<Photo> buscaFotoAvancada(String nome, String lugar, String descricao, Date date) {
        return Photo.busca(getCollablet(), nome, lugar, descricao, date);
    }

    public List<Photo> buscaFotoPorListaId(List<Object> listObjects) {
        List<Photo> photos = new ArrayList<Photo>(listObjects.size());
        for (Object object : listObjects) {
            if (object instanceof Photo) {
                photos.add((Photo) object);
            }
        }
        return photos;
    }

    public List<Photo> list() {
        return Photo.list(getCollablet());
    }

    public List<Photo> listPhotoByPageAndOrder(int pageSize, int pageNumber) {
        return Photo.listPhotoByPageAndOrder(getCollablet(), pageSize, pageNumber);
    }

    public String getDirImages() {
        return getCollablet().getProperty("dirImages");
    }

    public String getCropPrefix() {
        return getCollablet().getProperty("cropPrefix");
    }

    public String getThumbPrefix() {
        return getCollablet().getProperty("thumbPrefix");
    }

    public String getMostraPrefix() {
        return getCollablet().getProperty("mostraPrefix");
    }
}
