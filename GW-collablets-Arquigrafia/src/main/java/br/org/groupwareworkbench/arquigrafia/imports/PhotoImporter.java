package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.framework.Collablet;

public class PhotoImporter {

    String userName;
    String basePath;
    User importUser;
    File baseDir;
    
    public PhotoImporter(String userName, String basePath) {
        this.basePath = basePath;
        this.userName = userName;
        Collablet userMgr = Collablet.findByName("userMgr");
        importUser = User.findByLogin(userName, userMgr, AccountType.NATIVE);
        if (importUser == null) {
            throw new RuntimeException(String.format("Cannot found user %s to import images.", userName));
        }
        baseDir = new File(basePath);
        if (!baseDir.exists()) {
            throw new RuntimeException(String.format("Cannot found directory %s to import images.", basePath));
        }
    }
    
    public void importImages() {
        
        Collection<File> odsFilesToRead = getOdsFilesFromBaseDir(baseDir);
        if (odsFilesToRead.isEmpty()) {
            throw new RuntimeException(String.format("Cannot found any ods file in %s to import images.", basePath));
        }
        
        Collablet photoMgr = Collablet.findByName("photoMgr");
        Collablet tagMgr = Collablet.findByName("tagMgr");
        importPhotosFromOdsFileWithUser(odsFilesToRead, photoMgr, tagMgr);

    }

    private void importPhotosFromOdsFileWithUser(Collection<File> odsFilesToRead, Collablet photoMgr, Collablet tagMgr) {
        for (File odsFile : odsFilesToRead) {
            try {
                ImportLogger logger = new ImportLogger(odsFile);
                if ( logger.alreadyProcessed() ) {
                    System.out.println( String.format("File %s already imported, skipping file.",odsFile.getAbsolutePath()) );
                }                
                else {
                    
                    System.out.println(String.format("Reading metadata from %s.", odsFile.getAbsolutePath()));
                    logger.startFileLog();
                    MetaDataToPhotoMapper mapper = new MetaDataToPhotoMapper(logger);
                    Collection<ArquigrafiaImageMetadata> metadataImages = mapper.getMetadaFromFile(odsFile);
                    Map<String, List<Tag>> mappedTags = new OdsMetadataToTagImporter().mapTags(metadataImages, tagMgr);
                    saveTags(mappedTags, tagMgr);
                    Collection<Photo> mappedPhotos = new MetaDataToPhotoMapper(logger).getPhotosFromMetadata(metadataImages, photoMgr);
                    assignPhotosToUser(mappedPhotos, importUser);
                    savePhotos(mappedPhotos);
                    saveImage( logger, metadataImages, mappedPhotos );
                    assignPhotosToTags( mappedPhotos, mappedTags );
                    logger.finishFileLog(mappedPhotos.size());
                    
                }
                
            } catch (Exception e) {
                System.out.println(String.format("Error reading file %s.", odsFile.getAbsolutePath()));
                e.printStackTrace();
            }
        }
    }
    
    private void saveImage(ImportLogger logger , Collection<ArquigrafiaImageMetadata> metadataImages, Collection<Photo> mappedPhotos) {
        
        HashMap<String, ArquigrafiaImageMetadata> metadaImagesHash = new HashMap<String, ArquigrafiaImageMetadata>();
        for ( ArquigrafiaImageMetadata selectedMeta : metadataImages ) {
            metadaImagesHash.put( selectedMeta.TOMBO , selectedMeta);
        }
        for ( Photo photo : mappedPhotos ) {
            try {
            photo.saveImage( new FileInputStream( metadaImagesHash.get( photo.getTombo() ).getImageFile() ) );
            }
            catch (Exception ex) {
                logger.log(metadaImagesHash.get( photo.getTombo() ), ex.getMessage());
            }
        }
        
    }

    private void assignPhotosToTags(Collection<Photo> mappedPhotos, Map<String, List<Tag>> mappedTags) {
        for ( Photo selectedPhoto : mappedPhotos ) {
            assignPhotoToTags(selectedPhoto, mappedTags.get( selectedPhoto.getTombo() ));
        }
    }

    private void assignPhotoToTags(Photo selectedPhoto, List<Tag> list) {
        for ( Tag selectTag : list ) {
            selectTag.assign(selectedPhoto);
        }
    }

    private void assignPhotosToUser(Collection<Photo> mappedPhotos, User importUser) {
        for ( Photo selected : mappedPhotos ) {
            selected.assignUser(importUser);
        }
    }

    private void savePhotos(Collection<Photo> mappedPhotos) {
        for ( Photo selected : mappedPhotos ) {
            Photo existent = Photo.findByTombo( selected.getTombo() );
            if ( existent == null ) {
                selected.save();
            }
        }
    }

    private void saveTags(Map<String, List<Tag>> mappedTags, Collablet tagMgr) {
        
        Map<String, Tag> tagCacheMap = new HashMap<String, Tag>(); 
        for ( String tombo : mappedTags.keySet() ) {
            
            List<Tag> savedTags = new ArrayList<Tag>();
            List<Tag> tomboTags = mappedTags.get(tombo);
            for ( Tag selectedTomboTag : tomboTags ) {
                if ( tagCacheMap.containsKey(selectedTomboTag.getName()) ) {
                    savedTags.add(tagCacheMap.get(selectedTomboTag.getName()));
                }
                else {
                    Tag existent = Tag.findByName(selectedTomboTag.getName(), tagMgr);
                    if ( existent == null ) {
                        selectedTomboTag.save();
                        existent = selectedTomboTag;
                    }
                    savedTags.add(existent);
                    tagCacheMap.put( existent.getName() , existent);
                }
            }
            
        }
        
    }

    private Collection<File> getOdsFilesFromBaseDir(File baseDir) {
        OdsRecursiveFinder odsRecursiveFinder = new OdsRecursiveFinder();
        odsRecursiveFinder.find(baseDir);
        return odsRecursiveFinder.getResults();
    }
    
}
