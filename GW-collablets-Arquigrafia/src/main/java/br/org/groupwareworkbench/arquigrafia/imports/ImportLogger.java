package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;

public class ImportLogger {

    File metaDataFile;
    PrintStream logPrintStream;
    
    public ImportLogger(File odsToImport) {
        metaDataFile = odsToImport;
        logPrintStream = new PrintStream(System.out);
    }
    
    public void finishFileLog(int importedPhotoCount) {
        this.logPrintStream.println(String.format("\n\nImported %n images.", importedPhotoCount));
        this.logPrintStream.close();
    }

    public void startFileLog() throws IOException {
        this.logPrintStream = new PrintStream(getFileLog());
        getFileLog().createNewFile();
        this.logPrintStream.println(String.format("Starting to import %s.", metaDataFile.getAbsolutePath()));
    }

    public boolean alreadyProcessed() {
        File log = getFileLog();
        return log.exists();
    }
    
    public void log(ArquigrafiaImageMetadata metadataImage, String message) {
        this.logPrintStream.println(String.format("Log imagem tombo n. %s:\n %s ", metadataImage.TOMBO, message));
    }

    public File getFileLog() {
        File parent = this.metaDataFile.getParentFile();
        File log = new File(parent, String.format("%s%s", this.metaDataFile.getName(), ".log"));
        return log;
    }
    
}
