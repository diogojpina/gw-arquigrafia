package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowCommercialUses;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowModifications;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.date.ISO8601;
import br.org.groupwareworkbench.core.framework.Collablet;

/**
 * Classe que revisa inconsistencias que hajam entre os dados 
 * vindos do ODS e os armazenados no BD.
 * 
 * @author Vladi
 *
 */
public class PhotoReviewImport 
{
    private User importUser;
    private File baseDir;
    private Photo image;
    private Collection<File> odsFilesToRead;
    private Collablet photoMgr = Collablet.findByName("photoMgr");
    private Collablet tagMgr = Collablet.findByName("tagMgr");
    
    
    public PhotoReviewImport(String userName, String basePath) {
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
    
    public boolean reviewImportedImages() {
        
        if (odsFilesToRead.isEmpty()) {
            throw new RuntimeException(String.format("Cannot found any ods file in %s to review images.", baseDir));
        }
        
        File fileReviewLog = new File(baseDir, "review" + System.currentTimeMillis());
        try{
            fileReviewLog.createNewFile();
            ImportLogger logger = new ImportLogger(fileReviewLog);
            logger.startFileLog();
            logger.log("START REVIEW from:" + baseDir.getPath() + "====================== " + new Date());
            for (File odsFile : odsFilesToRead) {
                boolean reset = false;
                try {
                    logger.log(String.format("-------- Reading metadata from %s.", odsFile.getAbsolutePath()));
                    reset = reviewProcess(odsFile, logger);
                    
                } catch (Exception e) {
                    System.out.println(String.format("Error reading file %s.", odsFile.getAbsolutePath()));
                    e.printStackTrace();
                }
                if (reset) {
                    return true;
                }
            }
            logger.log("FINISH REVIEW from:" + baseDir.getPath() + "====================== " + new Date());
            logger.finishFileLog(1);
            
        } catch (Exception e) {
            
        }
        return false;
    }
    
    private boolean reviewProcess(File odsFile, ImportLogger logger) {

        MetaDataToPhotoMapper mapper = new MetaDataToPhotoMapper(logger);
        Map<String, ArquigrafiaImageMetadata> metadataImages = mapper.getMetadaFromFile(odsFile);
        Map<String, List<Tag>> mappedTags = new OdsMetadataToTagImporter().mapTags(metadataImages.values(), tagMgr);
        Collection<Photo> mappedPhotos = new MetaDataToPhotoMapper(logger).getPhotosFromMetadataNotBD(metadataImages.values(), photoMgr);
        
        long init = System.currentTimeMillis();
        for ( Photo photoOds : mappedPhotos ) {
            Photo armazenada = Photo.findByTombo(photoOds.getTombo());
            if (armazenada == null) {
                // ainda nao foi importada. continua
                logger.log("Photo ainda NAO importada tombo:" + photoOds.getTombo());
            } else {
                // comparando dados das fotos (armazenada e ods)
                boolean iguaisPhotos = comparePhotos(photoOds, armazenada, logger);
                // comparando tags das fotos (armazenada e ods)
                boolean iguaisTags = compareTags(mappedTags.get(photoOds.getTombo()), 
                                                Tag.listByObject(tagMgr, armazenada),
                                                logger);
                if (iguaisPhotos && iguaisTags)
                    logger.log("Photo OK tombo:" + photoOds.getTombo());
                else
                    logger.log("++ Photo ERROR tombo:" + photoOds.getTombo());
            }
        }
        /*if (mappedPhotos.isEmpty()) {
            return false;
        } else {
            long delayMediaSeg = ((System.currentTimeMillis()-init)/1000)/mappedPhotos.size();
            if (delayMediaSeg > 10) return true;
        }
        */
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
    
    private boolean compareTags(List<Tag> tags1, List<Tag> tags2, ImportLogger logger) 
    {
        boolean tudoOk = true;
        if (tags1 != null && tags2 != null) {
            if (tags1.size() != tags2.size()) {
                logger.log("tags diferentes em tamanho - ods: " + tags1.size() + " bd: " + tags2.size());
            }
            for (Tag tag1 : tags1) {
                if (! StringUtils.isBlank(tag1.getName())) {
                    boolean achei = false;
                    for (Tag tag2 : tags2) {
                        if (! StringUtils.isBlank(tag2.getName())) {
                            if (normalizeName(tag1.getName()).equals(normalizeName(tag2.getName()))) {
                                achei = true;
                                break;
                            }
                        }
                    }
                    if (! achei) {
                        logger.log("nao achei tag: " + tag1.getName());
                    }
                }
            }
        } else {
            if (tags1 != null || tags2 != null) {
                logger.log("tags1 ou tags2 null");
            }
        }
        
        return tudoOk;
    }

    private boolean comparePhotos(Photo ph1, Photo ph2, ImportLogger logger)
    {
        boolean tudoOk = true;
        LicenseMapper licenseMapper = new LicenseMapper();
        AllowCommercialUses com1 = ph1.getAllowCommercialUses();
        AllowCommercialUses com2 = ph2.getAllowCommercialUses();
        if (com1 != null && com2 != null) {
            if (! StringUtils.isBlank(com1.getAbrev()) && ! StringUtils.isBlank(com2.getAbrev())) {
                if (! com1.getAbrev().equals(com2.getAbrev())) {
                    logger.log("com diferentes abrev: " + com1.getAbrev() + " - " + com2.getAbrev());
                    tudoOk = false;
                }
                    
            } else {
                if (! StringUtils.isBlank(com1.getAbrev()) || ! StringUtils.isBlank(com2.getAbrev())) {
                    logger.log("com abrev com1 e com2 diferentes blank: " + com1.getAbrev() + " - " + com2.getAbrev());
                    tudoOk = false;
                }
            }
            if (! StringUtils.isBlank(com1.getName()) && ! StringUtils.isBlank(com2.getName())) {
                if (! com1.getName().equals(com2.getName())) {
                    logger.log("com diferentes name: "  + com1.getName() + " - " + com2.getName());
                    tudoOk = false;
                }
            } else {
                if (! StringUtils.isBlank(com1.getName()) || ! StringUtils.isBlank(com2.getName())) {
                    logger.log("com name com1 e com2 diferentes blank: " + com1.getName() + " - " + com2.getName());
                    tudoOk = false;
                }
            }
        } else {
            if (com1 != null || com2 != null) {
                logger.log("com com1 e com2 diferentes null");
                tudoOk = false;
            }
        }
        
        AllowModifications mod1 = ph1.getAllowModifications();
        AllowModifications mod2 = ph2.getAllowModifications();
        if (mod1 != null && mod2 != null) {
            if (! StringUtils.isBlank(mod1.getAbrev()) && ! StringUtils.isBlank(mod2.getAbrev())) {
                if (! mod1.getAbrev().equals(mod2.getAbrev())) {
                    logger.log("mod diferentes abrev: " + mod1.getAbrev() + " - " + mod2.getAbrev());
                    tudoOk = false;
                }
            } else {
                if (! StringUtils.isBlank(mod1.getAbrev()) || ! StringUtils.isBlank(mod2.getAbrev())) {
                    logger.log("mod abrev com1 e com2 diferentes blank: " + mod1.getAbrev() + " - " + mod2.getAbrev());
                    tudoOk = false;
                }
            }
            if (! StringUtils.isBlank(mod1.getName()) && ! StringUtils.isBlank(mod2.getName())) {
                if (! mod1.getName().equals(mod2.getName())) {
                    logger.log("mod diferentes name: "  + mod1.getName() + " - " + mod2.getName());
                    tudoOk = false;
                }
            } else {
                if (! StringUtils.isBlank(mod1.getName()) || ! StringUtils.isBlank(mod2.getName())) {
                    logger.log("mod name com1 e com2 diferentes blank: " + mod1.getName() + " - " + mod2.getName());
                    tudoOk = false;
                }
            }
        } else {
            if (mod1 != null || mod2 != null) {
                logger.log("mod com1 e com2 diferentes null");
                tudoOk = false;
            }
        }
        /*
        if (! StringUtils.isBlank(ph1.get) && ! StringUtils.isBlank(ph2.get)) {
            if (! ph1.get.equals(ph2.get)) {
                logger.log("diff");
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.get) || ! StringUtils.isBlank(ph2.get)) {
                logger.log("diff null");
                tudoOk = false;
            }
        }
        */
        if (! StringUtils.isBlank(ph1.getNomeArquivo()) && ! StringUtils.isBlank(ph2.getNomeArquivo())) {
            if (! ph1.getNomeArquivo().equals(ph2.getNomeArquivo())) {
                logger.log("nome arquivo diff: " + ph1.getNomeArquivo() + " - " + ph2.getNomeArquivo());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getNomeArquivo()) || ! StringUtils.isBlank(ph2.getNomeArquivo())) {
                logger.log("nome arquivo diff null: " + ph1.getNomeArquivo() + " - " + ph2.getNomeArquivo());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getTombo()) && ! StringUtils.isBlank(ph2.getTombo())) {
            if (! ph1.getTombo().equals(ph2.getTombo())) {
                logger.log("tombo diff: " + ph1.getTombo() + " - " + ph2.getTombo());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getTombo()) || ! StringUtils.isBlank(ph2.getTombo())) {
                logger.log("tombo diff null: " + ph1.getTombo() + " - " + ph2.getTombo());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getCharacterization()) && ! StringUtils.isBlank(ph2.getCharacterization())) {
            if (! ph1.getCharacterization().equals(ph2.getCharacterization())) {
                logger.log("characterization diff: "+ ph1.getCharacterization() + " - " + ph2.getCharacterization());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getCharacterization()) || ! StringUtils.isBlank(ph2.getCharacterization())) {
                logger.log("characterization diff null:"+ ph1.getCharacterization() + " - " + ph2.getCharacterization());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getName()) && ! StringUtils.isBlank(ph2.getName())) {
            if (! ph1.getName().equals(ph2.getName())) {
                logger.log("name diff: "+ ph1.getName() + " - " + ph2.getName());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getName()) || ! StringUtils.isBlank(ph2.getName())) {
                logger.log("name diff null: "+ ph1.getName() + " - " + ph2.getName());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getCountry()) && ! StringUtils.isBlank(ph2.getCountry())) {
            if (! ph1.getCountry().equals(ph2.getCountry())) {
                logger.log("country diff: "+ ph1.getCountry() + " - " + ph2.getCountry());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getCountry()) || ! StringUtils.isBlank(ph2.getCountry())) {
                logger.log("country diff null: "+ ph1.getCountry() + " - " + ph2.getCountry());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getState()) && ! StringUtils.isBlank(ph2.getState())) {
            if (! ph1.getState().equals(ph2.getState())) {
                logger.log("state diff: "+ ph1.getState() + " - " + ph2.getState());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getState()) || ! StringUtils.isBlank(ph2.getState())) {
                logger.log("state diff null: " + ph1.getState() + " - " + ph2.getState());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getCity()) && ! StringUtils.isBlank(ph2.getCity())) {
            if (! ph1.getCity().equals(ph2.getCity())) {
                logger.log("city diff: "+ ph1.getCity() + " - " + ph2.getCity());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getCity()) || ! StringUtils.isBlank(ph2.getCity())) {
                logger.log("city diff null:"+ ph1.getCity() + " - " + ph2.getCity());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getDistrict()) && ! StringUtils.isBlank(ph2.getDistrict())) {
            if (! ph1.getDistrict().equals(ph2.getDistrict())) {
                logger.log("district diff: "+ ph1.getDistrict() + " - " + ph2.getDistrict());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getDistrict()) || ! StringUtils.isBlank(ph2.getDistrict())) {
                logger.log("district diff null:"+ ph1.getDistrict() + " - " + ph2.getDistrict());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getStreet()) && ! StringUtils.isBlank(ph2.getStreet())) {
            if (! ph1.getStreet().equals(ph2.getStreet())) {
                logger.log("street diff: " + ph1.getStreet() + " - " + ph2.getStreet());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getStreet()) || ! StringUtils.isBlank(ph2.getStreet())) {
                logger.log("street diff null: " + ph1.getStreet() + " - " + ph2.getStreet());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getCollection()) && ! StringUtils.isBlank(ph2.getCollection())) {
            if (! ph1.getCollection().equals(ph2.getCollection())) {
                logger.log("collection diff: " + ph1.getCollection() + " - " + ph2.getCollection());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getCollection()) || ! StringUtils.isBlank(ph2.getCollection())) {
                logger.log("collection diff null: " + ph1.getCollection() + " - " + ph2.getCollection());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getImageAuthor()) && ! StringUtils.isBlank(ph2.getImageAuthor())) {
            if (! ph1.getImageAuthor().equals(ph2.getImageAuthor())) {
                logger.log("imgauthor diff: " + ph1.getImageAuthor() + " - " + ph2.getImageAuthor());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getImageAuthor()) || ! StringUtils.isBlank(ph2.getImageAuthor())) {
                logger.log("imgauthor diff null: " + ph1.getImageAuthor() + " - " + ph2.getImageAuthor());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getDescription()) && ! StringUtils.isBlank(ph2.getDescription())) {
            if (! ph1.getDescription().equals(ph2.getDescription())) {
                logger.log("description diff: " + ph1.getDescription() + " - " + ph2.getDescription());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getDescription()) || ! StringUtils.isBlank(ph2.getDescription())) {
                logger.log("description diff null: "+ ph1.getDescription() + " - " + ph2.getDescription());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getAditionalImageComments()) && ! StringUtils.isBlank(ph2.getAditionalImageComments())) {
            if (! ph1.getAditionalImageComments().equals(ph2.getAditionalImageComments())) {
                logger.log("aditionalcomm diff: " + ph1.getAditionalImageComments() + " - " + ph2.getAditionalImageComments());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getAditionalImageComments()) || ! StringUtils.isBlank(ph2.getAditionalImageComments())) {
                logger.log("aditionalcomm diff null: "+ ph1.getAditionalImageComments() + " - " + ph2.getAditionalImageComments());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getWorkAuthor()) && ! StringUtils.isBlank(ph2.getWorkAuthor())) {
            if (! ph1.getWorkAuthor().equals(ph2.getWorkAuthor())) {
                logger.log("workauthor diff: "+ ph1.getWorkAuthor() + " - " + ph2.getWorkAuthor());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getWorkAuthor()) || ! StringUtils.isBlank(ph2.getWorkAuthor())) {
                logger.log("workauthor diff null: "+ ph1.getWorkAuthor() + " - " + ph2.getWorkAuthor());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getDataCriacaoFormatada()) && ! StringUtils.isBlank(ph2.getDataCriacaoFormatada())) {
            if (! ph1.getDataCriacaoFormatada().equals(ph2.getDataCriacaoFormatada())) {
                logger.log("datacriacao diff: "+ ph1.getDataCriacaoFormatada() + " - " + ph2.getDataCriacaoFormatada());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getDataCriacaoFormatada()) || ! StringUtils.isBlank(ph2.getDataCriacaoFormatada())) {
                logger.log("datacriacao diff null: "+ ph1.getDataCriacaoFormatada() + " - " + ph2.getDataCriacaoFormatada());
                tudoOk = false;
            }
        }
        
        if (! StringUtils.isBlank(ph1.getWorkdateISO8601ToDate()) && ! StringUtils.isBlank(ph2.getWorkdateISO8601ToDate())) {
            if (! ph1.getWorkdateISO8601ToDate().equals(ph2.getWorkdateISO8601ToDate())) {
                logger.log("workdate diff: "+ ph1.getWorkdateISO8601ToDate() + " - " + ph2.getWorkdateISO8601ToDate());
                tudoOk = false;
            }
        } else {
            if (! StringUtils.isBlank(ph1.getWorkdateISO8601ToDate()) || ! StringUtils.isBlank(ph2.getWorkdateISO8601ToDate())) {
                logger.log("workdate diff null: "+ ph1.getWorkdateISO8601ToDate() + " - " + ph2.getWorkdateISO8601ToDate());
                tudoOk = false;
            }
        }

        ISO8601 catTime1 = ph1.getCataloguingTime();
        ISO8601 catTime2 = ph2.getCataloguingTime();
        if (catTime1 != null && catTime2 != null) {
            if (! StringUtils.isBlank(catTime1.toString()) && ! StringUtils.isBlank(catTime2.toString())) {
                if (! catTime1.toString().equals(catTime2.toString())) {
                    logger.log("cataloguingtime diff: "+ catTime1.toString() + " - " + catTime2.toString());
                    tudoOk = false;
                }
            } else {
                if (! StringUtils.isBlank(catTime1.toString()) || ! StringUtils.isBlank(catTime2.toString())) {
                    logger.log("cataloguingtime diff null: "+ catTime1.toString() + " - " + catTime2.toString());
                    tudoOk = false;
                }
            }    
        } else {
            if (catTime1 != null || catTime2 != null) {
                logger.log("cattime1 ou cattime2 null");
                tudoOk = false;
            }
        }
        
        return tudoOk;
    }
}
