package br.org.groupwareworkbench.arquigrafia.imports;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.core.framework.Collablet;

public class OdsMetadataToTagImporter {

    public Map<String, List<Tag>> mapTags(Collection<ArquigrafiaImageMetadata> metadataImages, Collablet tagMgr) {

        Map<String, List<Tag>> mappedTags = new HashMap<String, List<Tag>>();
        for (ArquigrafiaImageMetadata selectedMetaData : metadataImages) {

            ArrayList<Tag> metadataTags = new ArrayList<Tag>();
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_ELEMENTOS));
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_MATERIAIS));
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_TIPOLOGIA));
            mappedTags.put(selectedMetaData.TOMBO, metadataTags);

        }

        return mappedTags;

    }

    public List<Tag> getTags(Collablet tagMgr, String allTags) {

        ArrayList<Tag> mappedTags = new ArrayList<Tag>();
        String tags = allTags;
        String[] stringTags = allTags.split(",");
        for (String stringTag : stringTags) {
            String tagName = stringTag.trim();
            if (!tagName.equals("")) {
                Tag mappedTag = new Tag();
                mappedTag.setName(tagName);
                mappedTag.setCollablet(tagMgr);
                mappedTags.add(mappedTag);
            }
        }

        return mappedTags;

    }

}
