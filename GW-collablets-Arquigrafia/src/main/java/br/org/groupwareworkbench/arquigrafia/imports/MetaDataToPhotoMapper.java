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

    ImportLogger logger;

    public MetaDataToPhotoMapper(ImportLogger logger) {
        this.logger = logger;
    }

    public Collection<ArquigrafiaImageMetadata> getMetadaFromFile(File metaDataFile) {
        ArquigrafiaOdsReader imagesMetadataReader = new ArquigrafiaOdsReader(metaDataFile);
        Collection<ArquigrafiaImageMetadata> metadataImages = imagesMetadataReader.read();
        return metadataImages;
    }

    public Collection<Photo> getPhotosFromMetadata(Collection<ArquigrafiaImageMetadata> metaDatas, Collablet photoMgr) {
        List<Photo> mappedPhotos = new ArrayList<Photo>();
        for (ArquigrafiaImageMetadata selected : metaDatas) {
            try {
                mappedPhotos.add(getPhotoFromMetadata(selected, photoMgr));
            } catch (InvalidCellContents ex) {
                this.logger.log(selected, ex.getMessage());
            }
        }
        return mappedPhotos;
    }

    public Photo getPhotoFromMetadata(ArquigrafiaImageMetadata selectedMetaData, Collablet photoMgr)
            throws InvalidCellContents {
        Photo photo = Photo.findByTombo(selectedMetaData.TOMBO);
        if (photo == null) {
            photo = new Photo();
            this.logger.log(selectedMetaData, "Creating new photo.");
        } else {
            this.logger.log(selectedMetaData, "Editing new photo.");
        }
        metadataToPhoto(selectedMetaData, photo);
        photo.setCollablet(photoMgr);
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
            this.logger
                    .log(selectedMetaData, String.format("Cannot convert %s: \n%s", "DATA_IMAGEM", iex.getMessage()));
        }

        try {
            photo.setWorkdate(ISO8601.getISO8601Date(selectedMetaData.DATA_OBRA.trim()));
        } catch (ISO8601ViolationException iex) {
            this.logger.log(selectedMetaData, String.format("Cannot convert %s: \n%s", "DATA_OBRA", iex.getMessage()));
        }

        try {
            photo.setCataloguingTime(ISO8601.getISO8601Date(selectedMetaData.DATA_CATALOGACAO.trim()));
        } catch (ISO8601ViolationException iex) {
            this.logger.log(selectedMetaData,
                    String.format("Cannot convert %s: \n%s", "DATA_CATALOGACAO", iex.getMessage()));
        }

    }

}
