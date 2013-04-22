package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import org.hibernate.envers.tools.ArraysTools;
import org.hibernate.mapping.Array;
import org.odftoolkit.simple.SpreadsheetDocument;
import org.odftoolkit.simple.table.Cell;
import org.odftoolkit.simple.table.CellRange;
import org.odftoolkit.simple.table.Table;

public class ArquigrafiaOdsReader {

    private File odsTestResourceFile;

    public ArquigrafiaOdsReader(File odsTestResourceFile) {
        this.odsTestResourceFile = odsTestResourceFile;
    }

    public Collection<ArquigrafiaImageMetadata> read() {
        return getImageMetadatasFromFile(odsTestResourceFile);

    }

    private List<ArquigrafiaImageMetadata> getImageMetadatasFromFile(File sourceFile) {
        try {

            List<ArquigrafiaImageMetadata> imageMetadatas = new ArrayList<ArquigrafiaImageMetadata>(); 
            SpreadsheetDocument currentDocument = SpreadsheetDocument.loadDocument(new FileInputStream(sourceFile));
            int sheetCount = currentDocument.getSheetCount();
            String resourcePath = sourceFile.getParentFile().getAbsolutePath();
            for ( int sheetId = 0; sheetId < sheetCount ; sheetId++ ) {
                imageMetadatas.addAll( getImageMetadatasFromSheet( currentDocument.getSheetByIndex( sheetId ), resourcePath) );
            }
            currentDocument.close();
            return imageMetadatas;

        } catch (Exception exception) {
            throw new RuntimeException("Error reading ODS image metadata source file.", exception);
        }

    }

    private Collection<? extends ArquigrafiaImageMetadata> getImageMetadatasFromSheet(Table selectedSheet, String resourcePath) {

        List<ArquigrafiaImageMetadata> sheetImageMetadatas = new ArrayList<ArquigrafiaImageMetadata>();
        int rowCount = selectedSheet.getRowCount();
        boolean isReadind = true;
        //first row is header
        for ( int rowIndexAfterReader = 1; rowIndexAfterReader < rowCount && isReadind; rowIndexAfterReader++ ) {
            
            ArquigrafiaImageMetadata imageMetadataFromRow = getImageMetadataFromRow( selectedSheet.getCellRangeByPosition(0, rowIndexAfterReader, ArquigrafiaImageMetadataOdsIndexes.values().length, rowIndexAfterReader), resourcePath );
            if ( imageMetadataFromRow != null ) {
                sheetImageMetadatas.add(imageMetadataFromRow);
            }
            else {
                isReadind = false;
            }
            
        }
        
        return sheetImageMetadatas;
        
    }

    private ArquigrafiaImageMetadata getImageMetadataFromRow(CellRange selectedCellRange, String resourcePath) {
        
        
        Cell selectedCell = selectedCellRange.getCellByPosition( ArquigrafiaImageMetadataOdsIndexes.TOMBO.getColumnIndex() , 0);
        String tombo = selectedCell.getStringValue();
        if ( tombo != null && !tombo.trim().isEmpty() ) {
            
            
            String[] arrayRowValues = mapRowValuesToArray(selectedCellRange); 
            ArquigrafiaImageMetadata metadata = ArquigrafiaImageMetadata.fromRow(resourcePath, arrayRowValues);
            return metadata;
            
        }
        
        return null;
    }

    private String[] mapRowValuesToArray(CellRange selectedCellRange) {
        String [] values = new String[ArquigrafiaImageMetadataOdsIndexes.values().length];
        for ( ArquigrafiaImageMetadataOdsIndexes index : ArquigrafiaImageMetadataOdsIndexes.values() ) {
            values[index.getColumnIndex()] = selectedCellRange.getCellByPosition( index.getColumnIndex() , 0).getStringValue();
        }
        return values;
    }

    public int getSheetCount() {
        try {
            SpreadsheetDocument currentDocument =
                    SpreadsheetDocument.loadDocument(new FileInputStream(odsTestResourceFile));
            int count = currentDocument.getSheetCount();
            currentDocument.close();
            return count;
        } catch (Exception exception) {
            throw new RuntimeException("Error reading ODS image metadata source file.", exception);
        }
    }
}
