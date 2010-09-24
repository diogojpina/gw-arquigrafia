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

import java.util.Collection;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.core.framework.Collablet;

@RequestScoped
@Resource
public class AlbumMgrController {

    private final Result result;

    public AlbumMgrController(Result result) {
        this.result = result;
    }
    
    
    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}")
    public void list(final Collablet collablet, final AlbumMgrInstance albumMgr) {     
        result.include("collabletInstance", collablet);
        Collection<Album> albumList = albumMgr.list();
        result.include("albumList", albumList);
        result.use(Results.representation()).from(albumList).serialize();
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/create")
    public void create(final Collablet collablet, final AlbumMgrInstance albumMgr) {
        Album album = new Album();
        result.include("collabletInstance", collablet);
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/{id}")
    public void retrieve(final Collablet collablet, final AlbumMgrInstance albumMgr, final long id) {
        Album album = Album.findById(id);
        if (album == null) {
            this.result.notFound();
            return;
        }

        result.include("collabletInstance", collablet);
        result.include("album", album);
        result.use(Results.representation()).from(album).serialize();
    }

    @Post
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}")
    public void save(final Collablet collablet, AlbumMgrInstance albumMgr, Album album) {
        albumMgr.save(album);
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(collablet, albumMgr);
    }

    @Delete
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/{id}")
    public void delete(Collablet collablet, AlbumMgrInstance albumMgr, final long id) {
        Album album = Album.findById(id);
        if (album != null) album.delete();
        result.use(Results.logic()).redirectTo(AlbumMgrController.class).list(collablet, albumMgr);
    }

    /*@Get
    @Path(value="/groupware-workbench/{collablet}/albumMgr/{albumMgr}/resource/{resource*}")
    public File getResource(AlbumMgrInstance albumMgr, String resource) {
        return albumMgr.resourcePath(resource);
    }*/

}
