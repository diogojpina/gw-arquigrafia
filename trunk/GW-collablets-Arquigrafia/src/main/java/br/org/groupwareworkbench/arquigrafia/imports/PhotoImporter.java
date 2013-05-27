package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileInputStream;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.communic.tag.TagMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.framework.Collablet;

public class PhotoImporter {

    private User importUser;
    private File baseDir;
    private Photo image;
    private Collection<File> odsFilesToRead;
    private Collablet photoMgr = Collablet.findByName("photoMgr");
    private Collablet tagMgr = Collablet.findByName("tagMgr");

    
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

    public void buildImportImages() {

        if (odsFilesToRead.isEmpty()) {
            throw new RuntimeException(String.format("Cannot found any ods file in %s to import images.", baseDir));
        }
        
        for (File odsFile : odsFilesToRead) {
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
                
            } catch (Exception e) {
                System.out.println(String.format("Error reading file %s.", odsFile.getAbsolutePath()));
                e.printStackTrace();
            }
        }

    }
    
    private Collection<Photo> importProcess(File odsFile, ImportLogger logger) {

        MetaDataToPhotoMapper mapper = new MetaDataToPhotoMapper(logger);
        Map<String, ArquigrafiaImageMetadata> metadataImages = mapper.getMetadaFromFile(odsFile);
        Map<String, List<Tag>> mappedTags = new OdsMetadataToTagImporter().mapTags(metadataImages.values(), tagMgr);
        Collection<Photo> mappedPhotos = new MetaDataToPhotoMapper(logger).getPhotosFromMetadata(metadataImages.values(), photoMgr);
        
        for ( Photo photo : mappedPhotos ) {
            List<Tag> tomboTags = mappedTags.get(photo.getTombo());
            ArquigrafiaImageMetadata metadata = metadataImages.get(photo.getTombo());

            logger.log("Beginnig import for photo: " + photo.getTombo());

             with(photo);
             assignPhotoToUser();

             logger.log("save photo with id: " + photo.getTombo());
             savePhoto();
             
             logger.log("save tags: " + photo.getTombo());
             saveTags(tomboTags);
             
             logger.log("Save image with id: " + photo.getTombo());
             saveImage(metadata, logger);
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
        Photo existent = Photo.findByTombo( image.getTombo() );
        if ( existent == null ) {
            image.save();
        }
    }

    public void saveTags(List<Tag> mappedTags) {
        
        TagMgrInstance tagManager = (TagMgrInstance) tagMgr.getBusinessObject();
        Map<String, Tag> tagCacheMap = new HashMap<String, Tag>();
        
        for ( Tag selectedTomboTag : mappedTags ) {
            if (!tagCacheMap.containsKey(selectedTomboTag.getName()) ) {
                Tag existent = Tag.findByName(selectedTomboTag.getName(), tagMgr);
                if ( existent == null ) {
                    existent = selectedTomboTag;
                } 
                tagManager.saveWidgets(existent.getName(), image);
                tagCacheMap.put( existent.getName() , existent);
            }
        }
        
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
