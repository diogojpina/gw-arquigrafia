package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.framework.Collablet;

/**
 * Classe que atualiza os dados de uma foto e suas tags.
 * Nao atualiza as imagens criadas.
 * @author Vladi
 *
 */
public class PhotoUpdateImport 
{
    private User importUser;
    private File baseDir;
    private Photo image;
    private Collection<File> odsFilesToRead;
    private Collablet photoMgr = Collablet.findByName("photoMgr");
    private Collablet tagMgr = Collablet.findByName("tagMgr");
    
    public PhotoUpdateImport(String userName, String basePath) {
        defineImportUser(userName);
        defineBaseDir(basePath);
        this.odsFilesToRead = getOdsFilesFromBaseDir();
    }
    
    private void defineImportUser(String userName) {
        Collablet userMgr = Collablet.findByName("userMgr");
        importUser = User.findByLogin(userName, userMgr, AccountType.NATIVE);
        if (importUser == null) {
            throw new RuntimeException(String.format("Cannot found user %s to review images.", userName));
        }
    }

    private void defineBaseDir(String basePath) {
        baseDir = new File(basePath);
        if (!baseDir.exists()) {
            throw new RuntimeException(String.format("Cannot found directory %s to review images.", basePath));
        }
    }
    
    public Collection<File> getOdsFilesFromBaseDir() {
        OdsRecursiveFinder odsRecursiveFinder = new OdsRecursiveFinder();
        odsRecursiveFinder.find(this.baseDir);
        return odsRecursiveFinder.getResults();
    }
    
    public boolean updateImportedImages() {
        
        if (odsFilesToRead.isEmpty()) {
            throw new RuntimeException(String.format("Cannot found any ods file in %s to update images.", baseDir));
        }
        
        File fileReviewLog = new File(baseDir, "update" + System.currentTimeMillis());
        try{
            fileReviewLog.createNewFile();
            ImportLogger logger = new ImportLogger(fileReviewLog);
            logger.startFileLog();
            logger.log("START UPDATE from:" + baseDir.getPath() + "====================== " + new Date());
            for (File odsFile : odsFilesToRead) {
                boolean reset = false;
                try {
                    logger.log(String.format("-------- Reading metadata from %s.", odsFile.getAbsolutePath()));
                    reset = updateProcess(odsFile, logger);
                    
                } catch (Exception e) {
                    System.out.println(String.format("Error reading file %s.", odsFile.getAbsolutePath()));
                    e.printStackTrace();
                }
                if (reset) {
                    return true;
                }
            }
            logger.log("FINISH UPDATE from:" + baseDir.getPath() + "====================== " + new Date());
            logger.finishFileLog(1);
            
        } catch (Exception e) {
            
        }
        return false;
    }
    
    private boolean updateProcess(File odsFile, ImportLogger logger) 
    {
        MetaDataToPhotoMapper mapper = new MetaDataToPhotoMapper(logger);
        Map<String, ArquigrafiaImageMetadata> metadataImages = mapper.getMetadaFromFile(odsFile);
        Map<String, List<Tag>> mappedTags = new OdsMetadataToTagImporter().mapTags(metadataImages.values(), tagMgr);
        Collection<Photo> mappedPhotos = new MetaDataToPhotoMapper(logger).getPhotosFromMetadata(metadataImages.values(), photoMgr);
        
        for ( Photo photo : mappedPhotos ) {
            if (photo.getId() != null) {
                // photo ja existe no banco de dados portanto atualizar
                logger.log("++ Atualizando photo tombo: " + photo.getTombo());
                try {
                    photo.save();
                    
                    // atualizar tags da photo
                    List<Tag> tagsArmazenada = Tag.listByObject(tagMgr, photo);
                    List<Tag> tagsOds = mappedTags.get(photo.getTombo());
                    Hashtable<String, Tag> tagsApersistir = new Hashtable<String, Tag>();
                    
                    if (tagsOds != null && tagsArmazenada != null) {
                        // verificando quais tags devem ser armazenadas
                        for (Tag tagOds : tagsOds) {
                            if (tagOds != null && ! StringUtils.isBlank(tagOds.getName())) {
                                boolean achei = false;
                                String normOds = normalizeName(tagOds.getName());
                                for (Tag tagBD : tagsArmazenada) {
                                    if (tagBD != null && ! StringUtils.isBlank(tagBD.getName())) {
                                        String normBD = normalizeName(tagBD.getName());
                                        if (normOds.equals(normBD)) {
                                            achei = true;
                                            break;
                                        }
                                    }
                                }
                                if (!achei) {
                                    tagsApersistir.put(normOds, tagOds);
                                }
                            }
                        }
                        
                        // armazenar tags
                        if (! tagsApersistir.isEmpty()) {
                            logger.log("persistindo tags: " + tagsApersistir.size());
                            for (Tag tagPersist : tagsApersistir.values()) {
                                Tag bd = findTagBySql(tagPersist.getName());
                                if (bd != null) {
                                    logger.log("persist tagBD: (" + bd.getId() + ") " + bd.getName() + " == " +  tagPersist.getName());
                                    bd.increase();
                                    bd.assign(photo);
                                    bd.save();
                                } else {
                                    logger.log("persist NEW tag: " + tagPersist.getName());
                                    tagPersist.setCollablet(tagMgr);
                                    tagPersist.increase();
                                    tagPersist.assign(photo);
                                    tagPersist.save();
                                }
                            }
                        }
                        logger.log("=========================");
                    }
                } catch (Exception e) {
                    logger.log("Exception tombo: " + photo.getTombo() + " " + e.toString());
                }
            }
            
        }
        
        return false;
    }
    
    private String normalizeName(String name) 
    {
        String nam = name.toLowerCase();
        try {
            return Normalizer.normalize(nam, Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        } catch (Exception e) {
            return nam;
        }
    }
    
    /**
     * Mesmo metodo da clase PhotoImporter.
     * @param name
     * @return
     */
    private Tag findTagBySql(String name)
    {
        Tag tagCache = null;
        Long lid = Tag.findByNameMySql(name, tagMgr);
        
        if (lid != null) {
            tagCache = Tag.findById(lid);
        } 
        
        // as vezes (quase nunca) o entitymanager nao possui a referencia ao tag mas existe no banco de dados.
        if (lid != null && tagCache == null) {
            tagCache = Tag.findByName(name, tagMgr);
        }
        
        return tagCache;
    }
}
