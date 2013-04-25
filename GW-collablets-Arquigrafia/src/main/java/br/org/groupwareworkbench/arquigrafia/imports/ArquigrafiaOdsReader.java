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
                System.out.println("Lendo a planilha "+sheetId+" de "+sheetCount);
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
        for ( int rowIndexAfterHeader = 1; rowIndexAfterHeader < rowCount && isReadind; rowIndexAfterHeader++ ) {
            
            Cell[] cells = getRowCells(selectedSheet, rowIndexAfterHeader);
            ArquigrafiaImageMetadata imageMetadataFromRow = getImageMetadataFromRow(cells, resourcePath );
            if ( imageMetadataFromRow != null ) {
                imageMetadataFromRow.removeJpgExtensionFromTombo();
                sheetImageMetadatas.add(imageMetadataFromRow);
            }
            else {
                isReadind = false;
            }
            
        }
        
        return sheetImageMetadatas;
        
    }

    private Cell[] getRowCells(Table selectedSheet, int rowIndexAfterHeader) {
        Cell[] cells = new Cell[ArquigrafiaImageMetadataOdsIndexes.values().length];
        for ( int i = 0; i < cells.length; i++ ) {
            cells[i] = selectedSheet.getCellByPosition(i, rowIndexAfterHeader);
        }
        return cells;
    }

    private ArquigrafiaImageMetadata getImageMetadataFromRow(Cell[] cells, String resourcePath) {
        
        Cell selectedCell = cells[ArquigrafiaImageMetadataOdsIndexes.TOMBO.getColumnIndex()];
        String tombo = selectedCell.getStringValue();
        if ( tombo != null && !tombo.trim().isEmpty() ) {
            
            String[] arrayRowValues = mapRowValuesToArray(cells); 
            ArquigrafiaImageMetadata metadata = ArquigrafiaImageMetadata.fromRow(resourcePath, arrayRowValues);
            return metadata;
            
        }
        
        return null;
    }

    private String[] mapRowValuesToArray(Cell[] cells) {
        String [] values = new String[ArquigrafiaImageMetadataOdsIndexes.values().length];
        for ( ArquigrafiaImageMetadataOdsIndexes index : ArquigrafiaImageMetadataOdsIndexes.values() ) {
            values[index.getColumnIndex()] = cells[index.getColumnIndex()].getStringValue();
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
