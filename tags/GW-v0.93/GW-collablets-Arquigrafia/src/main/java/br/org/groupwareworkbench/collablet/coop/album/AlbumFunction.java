package br.org.groupwareworkbench.collablet.coop.album;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;


public final class AlbumFunction {

    public static boolean contains(Album album, Photo photo) {
        return album.contains(photo);
    }

}
