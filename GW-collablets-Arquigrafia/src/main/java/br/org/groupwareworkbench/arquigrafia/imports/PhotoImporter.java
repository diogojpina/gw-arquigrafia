package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileInputStream;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.bd.EntityManagerProvider;
import br.org.groupwareworkbench.core.bd.GenericReference;
import br.org.groupwareworkbench.core.framework.Collablet;

public class PhotoImporter {

    private User importUser;
    private File baseDir;
    private Photo image;
    private Collection<File> odsFilesToRead;
    private Collablet photoMgr = Collablet.findByName("photoMgr");
    private Collablet tagMgr = Collablet.findByName("tagMgr");

    private Map<String, Tag> tagMap3 = new HashMap<String, Tag>();
    private Map<String, Long> tagMapId3 = new HashMap<String, Long>(); 
    
    
    public PhotoImporter(String userName, String basePath) {
        defineImportUser(userName);
        defineBaseDir(basePath);
        this.odsFilesToRead = getOdsFilesFromBaseDir();
    }


    private void defineImportUser(String userName) {
        Collablet userMgr = Collablet.findByName("userMgr");
        importUser = User.findByLogin(userName, userMgr, AccountType.NATIVE);
        if (importUser == null) {
            throw new RuntimeException(String.format("Cannot found user %s to import images.", userName));
        }
    }

    private void defineBaseDir(String basePath) {
        baseDir = new File(basePath);
        if (!baseDir.exists()) {
            throw new RuntimeException(String.format("Cannot found directory %s to import images.", basePath));
        }
    }
    
    public Collection<File> getOdsFilesFromBaseDir() {
        OdsRecursiveFinder odsRecursiveFinder = new OdsRecursiveFinder();
        odsRecursiveFinder.find(this.baseDir);
        return odsRecursiveFinder.getResults();
    }

    public boolean buildImportImages() {

        if (odsFilesToRead.isEmpty()) {
            throw new RuntimeException(String.format("Cannot found any ods file in %s to import images.", baseDir));
        }
        
        //tagMap3 = new HashMap<String, Tag>();
        //EntityManagerProvider.clear();
        
        for (File odsFile : odsFilesToRead) {
            tagMap3 = new HashMap<String, Tag>();
            try {
                ImportLogger logger = new ImportLogger(odsFile);
                if ( logger.alreadyProcessed() ) {
                    System.out.println( String.format("File %s already imported, skipping file.",odsFile.getAbsolutePath()) );
                }                
                else {
                    System.out.println(String.format("Reading metadata from %s.", odsFile.getAbsolutePath()));
                    logger.startFileLog();
                    Collection<Photo> mappedPhotos = importProcess(odsFile, logger);
                    logger.finishFileLog(mappedPhotos.size());
                }
                boolean reset = saveAllTags3();
                if (reset) {
                    return true;
                }
                
            } catch (Exception e) {
                System.out.println(String.format("Error reading file %s.", odsFile.getAbsolutePath()));
                e.printStackTrace();
            }
        }
        return false;
        
        //saveAllTags3();

    }
    
    private Collection<Photo> importProcess(File odsFile, ImportLogger logger) {

        MetaDataToPhotoMapper mapper = new MetaDataToPhotoMapper(logger);
        Map<String, ArquigrafiaImageMetadata> metadataImages = mapper.getMetadaFromFile(odsFile);
        Map<String, List<Tag>> mappedTags = new OdsMetadataToTagImporter().mapTags(metadataImages.values(), tagMgr);
        Collection<Photo> mappedPhotos = new MetaDataToPhotoMapper(logger).getPhotosFromMetadata(metadataImages.values(), photoMgr);
        
        for ( Photo photo : mappedPhotos ) {
            if (photo.getId() == null) {
            List<Tag> tomboTags = mappedTags.get(photo.getTombo());
            ArquigrafiaImageMetadata metadata = metadataImages.get(photo.getTombo());

            logger.log("Beginnig import for photo with tombo: " + photo.getTombo());

             with(photo);
             assignPhotoToUser();

             logger.log("save photo with tombo: " + photo.getTombo());
             savePhoto();
             //image = Photo.findById(image.getId());
             System.out.println("image dados: " + image.getId());
             logger.log("save tags: " + tomboTags);
             //saveTags(tomboTags);
             saveTagsInMemory(tomboTags);
             
             logger.log("Save image with tombo: " + photo.getTombo());
             saveImage(metadata, logger);
            } else {
                System.out.println("image JA importada: " + photo.getId());   
            }
        }
        return mappedPhotos;
    }
    
    public void with(Photo photo) {
        this.image = photo;
    }

    public void assignPhotoToUser() {
        this.image.assignUser(this.importUser);
    }

    public void savePhoto() {
        image.save();
     }
    
    public void saveTagsInMemory(List<Tag> mappedTags) {
        for ( Tag selectedTomboTag : mappedTags ) {
            addAndAssignTagInMemory(selectedTomboTag, image);
        }
    }
    
    private void addAndAssignTagInMemory(Tag tag, Object image) 
    {
        try {
            String name = tag.getName();
            String norm = normalizeName(name);
            if (! StringUtils.isBlank(norm)) {
                Tag tagArm = tagMap3.get(norm);
                if (tagArm == null) {
                    tagArm = new Tag();
                    tagArm.setName(norm);
                    tagArm.setCollablet(tagMgr);
                }
                tagArm.increase();
                tagArm.assign(image);
                tagMap3.put(norm, tagArm);
            }
        } catch (Exception e) {
            
        }
    }
    
    private String normalizeName(String name) 
    {
        //String nam = name.toLowerCase();
        return name;
        /*try {
            return Normalizer.normalize(nam, Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        } catch (Exception e) {
            return "";
        }*/
    }
    
    private Tag findTagBySql(String name)
    {
        Tag tagCache = null;
        Long lid = Tag.findByNameMySql(name, tagMgr);
        System.out.println("findTagBySql: " + name + " collabid: " + tagMgr.getId() + " --> lid: " + lid);
        
        if (lid != null) {
            tagCache = Tag.findById(lid);
            if (tagCache != null) {
                /*Set<GenericReference> assignments = tagCache.getAssignments();
                if (assignments != null) {
                    System.out.println("QtdAssignments: " + assignments.size());
                } else {
                    System.out.println("QtdAssignments VEIO NULO !!");
                }*/
                tagMapId3.put(name, lid);
            }
        } 
        
        // as vezes (quase nunca) o entitymanager nao possui a referencia ao tag mas existe no banco de dados.
        if (lid != null && tagCache == null) {
            System.out.println("EXTRANHO EXISTE ID NAO EXISTE NO CACHE DO ENTITY MANAGER: " + name + " id: " + lid);
            tagCache = Tag.findByName(name, tagMgr);
        }
        
        return tagCache;
    }
    
    private boolean saveAllTags3() {
        boolean reset = false;
        int contaNaoSalvou1=0, contaNaoSalvou2=0, contaErroGener=0;
        int contNaoExist = 0, contExist=0;
        long ini = System.currentTimeMillis();
        Collection<Tag> values = tagMap3.values();
        int contaPos = 0;
        //System.out.println("\nSalvando All Tags: " + values.size()+ " " + new Date() + "\n");
        int countReset = 0;
        for (Tag tag : values) {
            try {
                long ini2, ini3, end2, end3, ini4, end4=-1;
                boolean exist=false, realExist = false, exist2=false;
                contaPos++;
                ini2 = System.currentTimeMillis();
                //procurando se existe id
                String norm = normalizeName(tag.getName());
                Long idT = tagMapId3.get(norm);
                Tag findByName = null;
                if (idT != null) {
                    //se existe id procurar pelo id
                    findByName = Tag.findById(idT);
                    contExist++;
                    if (findByName != null) exist2=true;
                    exist=true;
                } else {
                    findByName = findTagBySql(norm);//Tag.findByName(tag.getName(), tagMgr);
                    if (findByName != null) realExist = true;
                    contNaoExist++;
                }
                    
                end2 = System.currentTimeMillis() - ini2;
                ini3 = System.currentTimeMillis();
                if (findByName != null) {
                    findByName.increase(tag.getCount());
                    Set<GenericReference> assignments = tag.getAssignments();
                    for (GenericReference gr : assignments) {
                        try{
                            findByName.assign(gr.getEntity());
                            //findByName.assignAndSave(gr);
                        } catch (Exception e) {
                            e.printStackTrace();
                            contaErroGener++;
                        }
                        
                    }
                    try {
                        findByName.save();
                        if (findByName.getId() != null) {
                            ini4 = System.currentTimeMillis();
                            //Tag.findById(findByName.getId());
                            end4 = System.currentTimeMillis() - ini4;
                            tagMapId3.put(normalizeName(findByName.getName()), findByName.getId());
                        }
                    } catch(Exception e) {
                        contaNaoSalvou1++;
                        System.out.println("Erro ao salvar PERSISTIDO: " + tag.getName());
                    }
                } else {
                    try {
                        tag.save();
                        if (tag.getId() != null) {
                            ini4 = System.currentTimeMillis();
                            //Tag.findById(tag.getId());
                            end4 = System.currentTimeMillis() - ini4;
                            tagMapId3.put(normalizeName(tag.getName()), tag.getId());
                        }
                        
                    } catch(Exception e) {
                        contaNaoSalvou2++;
                        System.out.println("\n\n\nErro ao salvar NOVO: " + tag.getName() + "\n\n\n");
                    }
                }
                end3 = System.currentTimeMillis() - ini3;
                if (! exist)
                    System.out.println("[" + contaPos + "] Salvando id:" + tag.getId() + " " + tag.getName() + " F: " + end2 + " I: " + end3 + " FbyID:" + end4 + " existe:" + exist + "(id:" + exist2 + ") realEx:" + realExist);
                else
                    System.out.println("[" + contaPos + "] EXISTE id:" + tag.getId() + " " + tag.getName() + " F: " + end2 + " I: " + end3 + " FbyID:" + end4 + " existe:" + exist + "(id:" + exist2 + ") realEx:" + realExist);             
                if (end3 > 1000) {
                    if (countReset > 4) {
                        System.out.println("RESETING ENTITY MANAGER !" + " " + new Date());
                        //EntityManagerProvider.clear();
                        reset = true;
                        countReset = 0;
                    } else {
                        countReset++;
                    }
                }
            } catch (Exception e) {
                System.out.println("Deu erro ao salvar tag: " + tag.getName());
            }
        }
        long end = System.currentTimeMillis() - ini;
        int salvreal = values.size() - contaNaoSalvou1 - contaNaoSalvou2;
        System.out.println("\nSalvandoTags em: (" + end + ") totaltags:" + values.size() + " reais: " + salvreal + " CE:" + contExist + " CNE:" + contNaoExist + " CGEN:" + contaErroGener+" RESET:" + reset +"\n");
        return reset;
    }
        

    public void saveTags(List<Tag> mappedTags) {
        
        Map<String, Tag> tagCacheMap = new HashMap<String, Tag>();
        
        for ( Tag selectedTomboTag : mappedTags ) {
            if (!tagCacheMap.containsKey(selectedTomboTag.getName()) ) {
                Tag existent = Tag.findByName(selectedTomboTag.getName(), tagMgr);
                if ( existent == null ) {
                    existent = selectedTomboTag;
                    addAndAssignTag(existent, image);
                } else {
                    if (!existent.contains(image)) {
                        addAndAssignTag(existent, image);
                    } 
                }
                
                tagCacheMap.put( existent.getName() , existent);
            }
        }
        
    }    
    
    private void addAndAssignTag(Tag tag, Object image) {
        String name = tag.getName();
        Tag t = Tag.findByName(name, tagMgr);

        if (t == null) {
            t = new Tag();
            t.setName(name);
            t.setCollablet(tagMgr);
        }
        t.increase();
        t.assign(image);
        t.save();
    }

    public void saveImage(ArquigrafiaImageMetadata metadataImage, ImportLogger logger) {
        
        try {
            image.saveImage( new FileInputStream( metadataImage.getImageFile() ) );
        }
        catch (Exception ex) {
            logger.log(metadataImage, ex.getMessage());
        }
        
    }

}
