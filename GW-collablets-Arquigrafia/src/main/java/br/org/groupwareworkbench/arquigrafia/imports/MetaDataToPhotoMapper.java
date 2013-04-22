package br.org.groupwareworkbench.arquigrafia.imports;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.core.framework.Collablet;

public class MetaDataToPhotoMapper {

    final File metaDataFile;

    MetaDataToPhotoMapper(File metaDataFile) {

        this.metaDataFile = metaDataFile;

    }

    public void doMapper() {
        ArquigrafiaOdsReader imagesMetadataReader = new ArquigrafiaOdsReader(metaDataFile);
        Collection<ArquigrafiaImageMetadata> metadataImages = imagesMetadataReader.read();
        List<Photo> mappedPhotos = mapPhotos(metadataImages);

    }

    private List<Photo> mapPhotos(Collection<ArquigrafiaImageMetadata> metadataImages) {
        ArrayList<Photo> mappedPhotos = new ArrayList<Photo>();
        Collablet photoMgr = Collablet.findByName("photoMgr");
        for (ArquigrafiaImageMetadata selectedMetaData : metadataImages) {
            Photo mappedPhoto = getPhotoFromMetadata(selectedMetaData);
            mappedPhoto.setCollablet(photoMgr);
            mappedPhoto.save();
            mappedPhotos.add(mappedPhoto);
        }
        return mappedPhotos;
    }

    private List<Tag> mapTags(Collection<ArquigrafiaImageMetadata> metadataImages) {
        ArrayList<Tag> mappedTags = new ArrayList<Tag>();
        Collablet tagMgr = Collablet.findByName("tagMgr");
        for (ArquigrafiaImageMetadata selectedMetaData : metadataImages) {

            mappedTags.addAll( getTags(tagMgr, selectedMetaData.TAG_ELEMENTOS) );
            mappedTags.addAll( getTags(tagMgr, selectedMetaData.TAG_MATERIAIS) );
            mappedTags.addAll( getTags(tagMgr, selectedMetaData.TAG_TIPOLOGIA) );

        }

        return mappedTags;
    }

    private Photo getPhotoFromMetadata(ArquigrafiaImageMetadata selectedMetaData) {

        return null;
        
    }

    private List<Tag> getTags(Collablet tagMgr, String allTags) {

        ArrayList<Tag> mappedTags = new ArrayList<Tag>();
        String tags = allTags;
        String[] stringTags = allTags.split(",");
        for (String stringTag : stringTags) {
            String tagName = stringTag.trim();
            if (!tagName.equals("")) {
                Tag mappedTag = Tag.findByName(tagName, tagMgr);
                if (mappedTag == null) {
                    mappedTag = new Tag();
                    mappedTag.setName(tagName);
                    mappedTag.setCollablet(tagMgr);
                }

                mappedTags.add(mappedTag);

            }
        }

        return mappedTags;

    }

}
