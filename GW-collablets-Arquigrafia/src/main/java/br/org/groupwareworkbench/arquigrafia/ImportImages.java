package br.org.groupwareworkbench.arquigrafia;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Date;

import org.odftoolkit.simple.SpreadsheetDocument;
import org.odftoolkit.simple.table.Cell;
import org.odftoolkit.simple.table.Row;
import org.odftoolkit.simple.table.Table;

import br.org.groupwareworkbench.arquigrafia.photo.Photo;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowCommercialUses;
import br.org.groupwareworkbench.arquigrafia.photo.Photo.AllowModifications;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.date.ISO8601;
import br.org.groupwareworkbench.core.date.ISO8601ViolationException;
import br.org.groupwareworkbench.core.framework.Collablet;

import com.ibm.icu.text.SimpleDateFormat;

public class ImportImages {

    public static final int BUFFER_SIZE = 1024;
    
    public static final String reportSuccessMessage = "End of report - Magic number: 34793824710238213265489543932033346583\n";
    
    public static final String CONTENT_BOOLEAN = "boolean";
    public static final String CONTENT_CURRENCY = "currency";
    public static final String CONTENT_DATE = "date";
    public static final String CONTENT_FLOAT = "float";
    public static final String CONTENT_PERCENTAGE = "percentage";
    public static final String CONTENT_STRING = "string";
    public static final String CONTENT_TIME = "time";

    public void run() throws Exception {

        try {
            String date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(new Date());
            
            String dirName = "/home/gw/imports/";
            
            File dir = new File(dirName);
            if (!dir.exists()) {
                throw new IllegalArgumentException(dirName + " does not exist. Giving up."); 
            }
            if (!dir.isDirectory()) {
                throw new IllegalArgumentException(dirName + " is not a directory. Giving up."); 
            }
            
            ArrayList<File> odsFiles = new ArrayList<File>();
            recursiveSearchODS(odsFiles, dir);
            System.out.println("--------------> ODS Files: " + odsFiles);
            
            FileOutputStream fos;
            BufferedOutputStream bos;
            PrintStream ps;
            
            File reportDir = new File("/home/gw/importReports");
            if (!reportDir.exists()) {
                reportDir.mkdir();
            }
            fos = new FileOutputStream(new File(String.format("/home/gw/importReports/import_report_%s.txt", date)));
            bos = new BufferedOutputStream(fos, BUFFER_SIZE);
            ps = new PrintStream(bos);
            
            ps.println(String.format("Import report (%s) - Automatically generated.", date));
            
            Collablet userMgr = Collablet.findByName("userMgr");
            User user = User.findByLogin("acervofau", userMgr, AccountType.NATIVE);
            if (user==null) {
                throw new Exception("User acervofau does not exist!!!! Cannot import any image. Please make sure this user exists before trying to import images.");
            }


            for (File odsFile : odsFiles) {
                try {
                    ps.println();
                    ps.println(String.format("########################################################### FILE %s", odsFile.getAbsolutePath()));
                    FileInputStream fis = new FileInputStream(odsFile);
                    
                    // Creates the OK file
                    {
                        String okFileName = odsFile.getCanonicalPath().substring(0, odsFile.getCanonicalPath().lastIndexOf('.')) + ".ok";
                        File okFile = new File(okFileName);
                        if(okFile.exists()) {
                            ps.println();
                            ps.println("\t!!!!! WARNING: OK file exists. Skipping this spreadsheet. !!!!!!!!");
                            continue;
                        }
                        okFile.createNewFile();
                    }
                    
                    SpreadsheetDocument document = SpreadsheetDocument.loadDocument(fis);
                    Table sheet = document.getSheetByIndex(0);
                    
                    Collablet tagMgr = Collablet.findByName("tagMgr");
                    Collablet photoMgr = Collablet.findByName("photoMgr");
                    
                    /*
                     * We simply throw away the first row, which may be used to hold column labels.
                     *
                     * It is easier to use the indexes 1, 2, 3... for table rows, since this is the standard used in
                     * spreadsheets. Therefore, we will always refer to the row according to this standard. On the other
                     * hand, getRow needs the row number to start in zero. So we correct the call to getRow using i-1
                     * instead of i.
                     */
                    int x = sheet.getRowCount();
                    System.out.println("################> " + x);
                    for (int i = 2; i <= x + 1 && !sheet.getCellByPosition(0, i-1).getStringValue().equals(""); i++) {
                        System.out.println("-------------------------------------------");
                        System.out.println(System.currentTimeMillis() + ": Importing row " + i);
                        try {
                            
                            ps.println();
                            ps.println(String.format("========================== (row %d)", i));
                            ps.println();
                            
                            // A - 0 - Tombo
                            String tombo = stringValue(sheet, ps, 0, i, true).trim();
                            
                            ps.println();
                            ps.println(String.format("\tTombo: %s", tombo));
                            ps.println();
                            
                            Photo photo = Photo.findByTombo(tombo);
                            boolean newPhoto;
                            if (photo==null) {
                                ps.println("\tCREATING");
                                photo = new Photo();
                                newPhoto = true;
                            } else {
                                ps.println("\tUPDATING");
                                newPhoto = false;
                            }
                            
                            ps.println();
                            
                            photo.assignUser(user);
                            
                            String fileName = tombo + ".jpg";
                            // Checking if the file exists. If it doesn't, give it up right now.
                            File imageFile = new File(odsFile.getParentFile().getCanonicalPath() + "/" + fileName);
                            if (!imageFile.exists()) {
                                if (newPhoto) {
                                    ps.println(String.format("\tFATAL: File %s NOT FOUND. Giving up importing %d.", imageFile, tombo));
                                    continue;
                                }
                                // else
                                ps.print(String.format("\tINFO: File %s NOT FOUND, but that is OK since we are just updating an image.", imageFile, tombo));
                            }
                            photo.setNomeArquivo(fileName);
                            photo.setTombo(tombo);
                            
                            // B - 1 - Caracterização
                            
                            // C - 2 - Nome
                            String nome = stringValue(sheet, ps, 2, i, true);
                            photo.setName(nome);
                            
                            // D - 3 - País
                            String pais = stringValue(sheet, ps, 3, i, true);
                            photo.setCountry(pais);
                            
                            // E - 4 - Estado
                            String estado = stringValue(sheet, ps, 4, i, true);
                            photo.setState(estado);
                            
                            // F - 5 - Cidade
                            String cidade = stringValue(sheet, ps, 5, i, true);
                            photo.setCity(cidade);
                            
                            // G - 6 - Bairro
                            String bairro = stringValue(sheet, ps, 6, i, true);
                            photo.setDistrict(bairro);
                            
                            // H - 7 - Rua
                            String rua = stringValue(sheet, ps, 7, i, true);
                            photo.setStreet(rua);
                            
                            // I - 8 - Coleção
                            String colecao = stringValue(sheet, ps, 8, i, true);
                            photo.setCollection(colecao);
                            
                            // J - 9 - Autor da Imagem
                            String autorImagem = stringValue(sheet, ps, 9, i, true);
                            photo.setImageAuthor(autorImagem);
                            
                            // K - 10 - Data da Imagem
                            {
                                String d = "";
                                try {
                                    d = stringValue(sheet, ps, 10, i, false);
                                } catch (InvalidCellContents e) {
                                    
                                }
                                if(! d.trim().equalsIgnoreCase("null")) {
                                    try {
                                        photo.setDataCriacao(new ISO8601(d));
                                    } catch (ISO8601ViolationException e) {
                                        ps.println(String.format("\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data da obra.", d, 'A' + 10, i));
                                    }
                                }
                            }
                            
                            // L - 11 - Autor da Obra
                            String autorDaObra = stringValue(sheet, ps, 11, i, true);
                            if(autorDaObra.trim().equalsIgnoreCase("null")) {
                                photo.setWorkAuthor(null);
                            } else {
                                photo.setWorkAuthor(autorDaObra);
                            }
                            
                            // M - 12 - Data da Obra
                            {
                                String dataObra = stringValue(sheet, ps, 12, i, true);
                                try {
                                    photo.setWorkdate(new ISO8601(dataObra));
                                } catch (ISO8601ViolationException e) {
                                    ps.println(String.format("\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data da obra.", dataObra, 'A' + 12, i));
                                }
                            }
                            
                            // N - 13 - Licença
                            String licenca = stringValue(sheet, ps, 13, i, true).trim();
                            if(licenca.equals("")) {
                                ps.println(String.format("\tFATAL: Copyright data not found at row %d.", i));
                                throw new InvalidCellContents();
                            }
                            if(!licenca.contains("-")) {
                                ps.println(String.format("\tFATAL: Invalid copyright data at row %d: %s. This cell should have a hyphen character.", i, licenca));
                                throw new InvalidCellContents();
                            }
                            try {
                                AllowCommercialUses allowCommercialUses = AllowCommercialUses.valueOf( licenca.substring(0, licenca.indexOf('-')).toUpperCase().trim());
                                AllowModifications allowModifications = AllowModifications.valueOf(licenca.substring(licenca.indexOf('-') + 1, licenca.length()).toUpperCase().trim());
                                photo.setAllowCommercialUses(allowCommercialUses);
                                photo.setAllowModifications(allowModifications);
                            } catch (Exception e) {
                                /* If anything happens, especially if an IllegalArgumentException happens
                                 * (which means there was a problem parsing a string to an enumeration
                                 * value in the Enumeration.valueOf method), we abort the import of this row.
                                 */
                                ps.println(String.format("\tFATAL: Error reading copyright data. This is the data from the spreadsheet: \"%s\" and this is the exception message: \"%s\"", licenca, e.getMessage()));
                                throw new InvalidCellContents();
                            }
                            
                            // O - 14 - Descrição
                            String descricao = stringValue(sheet, ps, 14, i, true);
                            photo.setDescription(descricao);
                            
                            // P - 15 - Tags Materiais
                            String tagsMateriais = stringValue(sheet, ps, 15, i, true);
                            
                            // Q - 16 - Tags Elementos
                            String tagsElementos = stringValue(sheet, ps, 16, i, true);
                            
                            // R - 17 - Tags Tipologia
                            String tagsTipologia = stringValue(sheet, ps, 17, i, true);
                            
                            // S - 18 - Observações
                            String observacoes = stringValue(sheet, ps, 18, i, true);
                            photo.setAditionalImageComments(observacoes);
                            // TODO: where to put this?
                            
                            // T - 19 - Data de Catalogação
                            String dataCatalogacao = stringValue(sheet, ps, 19, i, false);
                            try {
                                photo.setCataloguingTime(new ISO8601(dataCatalogacao));
                            } catch (ISO8601ViolationException e) {
                                ps.println(String.format("\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data de catalogacao.", dataCatalogacao, 'A' + 19, i));
                            }
                            
                            ps.println("\tINFO: Saving data to database:");
                            ps.flush();

                            photo.setCollablet(photoMgr);
                            photo.save();
                            if (imageFile.exists()) {
                                photo.saveImage(new FileInputStream(imageFile));
                            }
                            
                            ps.println(String.format("\t\t       Nome = %s", nome));
                            ps.println(String.format("\t\t       Pais = %s", pais));
                            ps.println(String.format("\t\tD. Catalog. = %s", dataCatalogacao));
                            ps.println(String.format("\t\t   Image ID = %d", photo.getId()));
                            
                            System.out.println("\tPhoto object saved. Will save tags now...");
                            String tags = tagsMateriais + "," + tagsElementos + "," + tagsTipologia;
                            while (tags.contains(",")) {
                                String tagName = tags.substring(0, tags.indexOf(','));
                                tagName = tagName.trim();
                                if(!tagName.equals("")) {
                                    Tag tag = Tag.findByName(tagName, tagMgr);
                                    if (tag==null) {
                                        tag = new Tag();
                                        tag.setName(tagName);
                                        tag.setCollablet(tagMgr);
                                    }
                                    tag.assign(photo);
                                    tag.save();
                                }
                                tags = tags.substring(tags.indexOf(',') + 1);
                            }
                            
                            System.out.println("\tTags saved.");
                            ps.println();
                            ps.println("\t#### SUCCESS #### (:P)");
                        } catch (InvalidCellContents e) {
                            ps.println("\tInvalid cell contents: " + e.getLocalizedMessage());
                        } catch (Exception e) {
                            ps.println("\tUnknown exception: " + e.getLocalizedMessage());
                        } finally {
                            ps.flush();
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    ps.println();
                    ps.println();
                    ps.println("###########################################################");
                    ps.println("###########################################################");
                    ps.println(reportSuccessMessage);
                    ps.println();
                    ps.flush();
                    bos.flush();
                    fos.flush();
                    ps.close();
                    bos.close();
                    fos.close();
                }
            }
                
        } catch (IOException e) {
            System.err.println("FATAL ERROR: Could not even write to error file.");
            e.printStackTrace();
        }
    }

    public String removeAllWhiteSpace(String string) {
        return string.replaceAll("\\S", "");
    }

    public String stringValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber, boolean logError) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell==null) {
            return "";
        }
        if (cell.getValueType()==null) {
            return "";
        }
        if (cell.getValueType().equals(CONTENT_FLOAT) || cell.getValueType().equals(CONTENT_STRING)) {
            return cell.getStringValue();
        }
        if (logError) {
            ps.println(String.format("\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but should be \"string\".", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        }
        throw new InvalidCellContents();
    }
    
    public int intValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell==null) {
            return 0;
        }
        if (cell.getValueType()==null) {
            return 0;
        }
        if (cell.getValueType().equals(CONTENT_FLOAT)) {
            return cell.getDoubleValue().intValue();
        }
        ps.println(String.format("\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but should be \"int\".", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }
    
    public Date dateValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell==null) {
            return null;
        }
        if (cell.getValueType()==null) {
            return null;
        }
        if (cell.getValueType().equals(CONTENT_DATE)) {
            return cell.getDateValue().getTime();
        }
        ps.println(String.format("\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but shoud be \"date\".", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }
    
    public void recursiveSearchODS(ArrayList<File> list, File dir) {
        for (File file : dir.listFiles()) {
            String path = file.getAbsolutePath();
            if (file.isFile() && path.toLowerCase().endsWith(".ods")) {
                list.add(file);
            }
            if(file.isDirectory()) {
                recursiveSearchODS(list, file);
            }
        }
    }
}