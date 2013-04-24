package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.org.groupwareworkbench.arquigrafia.InvalidCellContents;
import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.date.ISO8601;
import br.org.groupwareworkbench.core.date.ISO8601ViolationException;
import br.org.groupwareworkbench.core.framework.Collablet;

public class MetaDataToPhotoMapper {

    File metaDataFile;
    PrintStream logPrintStream;

    public MetaDataToPhotoMapper(File metaDataFile) throws FileNotFoundException  {
        this.metaDataFile = metaDataFile;
        this.logPrintStream = new PrintStream(getFileLog());
    }
    
    public MetaDataToPhotoMapper(File metaDataFile, PrintStream logPrintStream) {
        this.metaDataFile = metaDataFile;
        this.logPrintStream = logPrintStream;
    }

    public void doMapper(User user) throws IOException {

        this.logPrintStream.println(String.format("Reading metadata from %s.", metaDataFile.getAbsolutePath()));
        if (!alreadyProcessed()) {
            this.logPrintStream.println(String.format("File %s already imported, skipping file.", metaDataFile.getAbsolutePath()));
        }
        else {
            getFileLog().createNewFile();
            ArquigrafiaOdsReader imagesMetadataReader = new ArquigrafiaOdsReader(metaDataFile);
            Collection<ArquigrafiaImageMetadata> metadataImages = imagesMetadataReader.read();
            Collablet photoMgr = Collablet.findByName("photoMgr");
            Map<String, List<Tag>> mappedTags = mapTags(metadataImages);
            for (ArquigrafiaImageMetadata metadata : metadataImages) {

                try {
                    Photo mappedPhoto = mapPhoto(metadata, user, photoMgr);
                    for (Tag selectedTag : mappedTags.get(mappedPhoto.getTombo())) {
                        selectedTag.assign(mappedPhoto);
                    }
                    mappedPhoto.saveImage(new FileInputStream(metadata.getImageFile()));
                    log(metadata, "Image imported sucessefully.");
                } catch (Exception ex) {
                    log(metadata, ex.getMessage());
                }
            }
        }
        

    }

    private boolean alreadyProcessed() {
        File log = getFileLog();
        return log.exists();
    }

    public Photo mapPhoto(ArquigrafiaImageMetadata metadataImage, User user, Collablet photoMgr)
            throws InvalidCellContents {

        Photo mappedPhoto = null;
        mappedPhoto = getPhotoFromMetadata(metadataImage);
        mappedPhoto.setCollablet(photoMgr);
        mappedPhoto.assignUser(user);
        mappedPhoto.save();
        return mappedPhoto;

    }

    private Map<String, List<Tag>> mapTags(Collection<ArquigrafiaImageMetadata> metadataImages) {

        Map<String, List<Tag>> mappedTags = new HashMap<String, List<Tag>>();
        Collablet tagMgr = Collablet.findByName("tagMgr");
        for (ArquigrafiaImageMetadata selectedMetaData : metadataImages) {

            ArrayList<Tag> metadataTags = new ArrayList<Tag>();
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_ELEMENTOS));
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_MATERIAIS));
            metadataTags.addAll(getTags(tagMgr, selectedMetaData.TAG_TIPOLOGIA));
            mappedTags.put(selectedMetaData.TOMBO, metadataTags);

        }

        return mappedTags;

    }

    public Photo getPhotoFromMetadata(ArquigrafiaImageMetadata selectedMetaData) throws InvalidCellContents {
        Photo photo = Photo.findByTombo(selectedMetaData.TOMBO);
        if (photo == null) {
            photo = new Photo();
            log(selectedMetaData, "Creating new photo.");
        } else {
            log(selectedMetaData, "Editing new photo.");
        }
        metadataToPhoto(selectedMetaData, photo);
        return photo;

    }

    public void metadataToPhoto(ArquigrafiaImageMetadata selectedMetaData, Photo photo) throws InvalidCellContents {
        // TODO tests
        if (!selectedMetaData.getImageFile().exists()) {
            throw new InvalidCellContents(String.format("Image file %s not found.", selectedMetaData.getImageFile()
                    .getAbsolutePath()));
        }

        LicenseMapper licenseMapper = new LicenseMapper();
        photo.setAllowCommercialUses(licenseMapper.getAllowCommercialUses(selectedMetaData.LICENCA));
        photo.setAllowModifications(licenseMapper.getAllowModifications(selectedMetaData.LICENCA));

        photo.setNomeArquivo(selectedMetaData.getFileName());
        photo.setTombo(selectedMetaData.TOMBO);
        photo.setCharacterization(selectedMetaData.CARACTERIZACAO);
        photo.setName(selectedMetaData.NOME);
        photo.setCountry(selectedMetaData.PAIS);
        photo.setState(selectedMetaData.ESTADO);
        photo.setCity(selectedMetaData.CIDADE);
        photo.setDistrict(selectedMetaData.BAIRRO);
        photo.setStreet(selectedMetaData.RUA);
        photo.setCollection(selectedMetaData.COLECAO);
        photo.setImageAuthor(selectedMetaData.AUTOR_IMAGEM);
        photo.setDescription(selectedMetaData.DESCRICAO);
        photo.setAditionalImageComments(selectedMetaData.OBSERVACOES);

        if (!(selectedMetaData.AUTOR_OBRA.trim().equalsIgnoreCase("null") || selectedMetaData.AUTOR_OBRA.trim()
                .isEmpty())) {
            photo.setWorkAuthor(selectedMetaData.AUTOR_OBRA.trim());
        }

        try {
            photo.setDataCriacao(ISO8601.getISO8601Date(selectedMetaData.DATA_IMAGEM.trim()));
        } catch (ISO8601ViolationException iex) {
            log(selectedMetaData, String.format("Cannot convert %s: \n%s", "DATA_IMAGEM", iex.getMessage()));
        }

        try {
            photo.setWorkdate(ISO8601.getISO8601Date(selectedMetaData.DATA_OBRA.trim()));
        } catch (ISO8601ViolationException iex) {
            log(selectedMetaData, String.format("Cannot convert %s: \n%s", "DATA_OBRA", iex.getMessage()));
        }

        try {
            photo.setCataloguingTime(ISO8601.getISO8601Date(selectedMetaData.DATA_CATALOGACAO.trim()));
        } catch (ISO8601ViolationException iex) {
            log(selectedMetaData, String.format("Cannot convert %s: \n%s", "DATA_CATALOGACAO", iex.getMessage()));
        }

    }

    public List<Tag> getTags(Collablet tagMgr, String allTags) {

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
                    mappedTag.save();
                }

                mappedTags.add(mappedTag);

            }
        }

        return mappedTags;

    }

    public void log(ArquigrafiaImageMetadata metadataImage, String message) {
        this.logPrintStream.println(String.format("Log imagem tombo n. %s:\n %s ", metadataImage.TOMBO, message));
    }
    
    public File getFileLog() {
        File parent = this.metaDataFile.getParentFile();
        File log = new File(parent, String.format("%s%s" , this.metaDataFile.getName(),".log") );
        return log;
    }

}
