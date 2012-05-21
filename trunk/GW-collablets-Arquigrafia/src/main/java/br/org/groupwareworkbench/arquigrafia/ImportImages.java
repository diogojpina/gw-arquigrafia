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
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.collablet.coord.user.User.AccountType;
import br.org.groupwareworkbench.core.framework.Collablet;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

public class ImportImages {

    public static final int BUFFER_SIZE = 1024;
    
    public static final String reportSuccessMessage = "End of report - Magic number: 8490283492384235832432435344839547\n";
    
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
            if(!dir.isDirectory()) {
                throw new IllegalArgumentException(dirName + " is not a directory. Giving up."); 
            }
            
            ArrayList<File> odsFiles = new ArrayList<File>();
            recursiveSearchODS(odsFiles, dir);
            System.out.println("--------------> ODS Files: " + odsFiles);
            
            FileOutputStream fos;
            BufferedOutputStream bos;
            PrintStream ps;
            
//            if (outputToStdout) {
//                fos = null;
//                bos = null;
//                ps = System.err;
//            } else {
                fos = new FileOutputStream(new File(String.format("import_report_%s.txt", date)));
                bos = new BufferedOutputStream(fos, BUFFER_SIZE);
                ps = new PrintStream(bos);
//            }
            
            for(File odsFile : odsFiles) {
                try {
                    ps.println(String.format("Import report (%s) - Automatically generated.", date));
                    FileInputStream fis = new FileInputStream(odsFile);
                    
                    SpreadsheetDocument document = SpreadsheetDocument.loadDocument(fis);
                    Table sheet = document.getSheetByIndex(0);
                    
                    Collablet tagMgr = Collablet.findByName("tagMgr");
                    Collablet userMgr = Collablet.findByName("userMgr");
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
                            
                            Photo photo = new Photo();
                            
                            //User user = User.findById(1);
                            User user = User.findByLogin("admin", userMgr, AccountType.NATIVE);
                            
                            photo.assignUser(user);
                            
                            // A - 0 - Tombo
                            int tombo = intValue(sheet, ps, 0, i);
                            // Checking if the file exists. If it doesn't, give it up right now.
                            String fileName = tombo + ".jpg";
//                            File file = new File(fileName);
//                            if (!file.exists()) {
//                                ps.println(String.format("File %s not found. Could not import row %d.", fileName, i));
//                                throw new InvalidCellContents();
//                            }
                            
                            
                            File imageFile = new File(dirName + "/" + fileName);
                            if(!imageFile.exists()) {
                                System.out.println("File " + imageFile + " does not exist. Giving up.");
                                continue;
                            }
                            
                            photo.setNomeArquivo(fileName);
                            
                            // B - 1 - Caracterização
                            
                            // C - 2 - Nome
                            String nome = stringValue(sheet, ps, 2, i);
                            photo.setName(nome);
                            
                            // D - 3 - País
                            String pais = stringValue(sheet, ps, 3, i);
                            photo.setCountry(pais);
                            
                            // E - 4 - Estado
                            String estado = stringValue(sheet, ps, 4, i);
                            photo.setState(estado);
                            
                            // F - 5 - Cidade
                            String cidade = stringValue(sheet, ps, 5, i);
                            photo.setCity(cidade);
                            
                            // G - 6 - Bairro
                            String bairro = stringValue(sheet, ps, 6, i);
                            photo.setDistrict(bairro);
                            
                            // H - 7 - Rua
                            String rua = stringValue(sheet, ps, 7, i);
                            photo.setStreet(rua);
                            
                            // I - 8 - Coleção
                            String colecao = stringValue(sheet, ps, 8, i);
                            photo.setCollection(colecao);
                            
                            // J - 9 - Autor da Imagem
                            String autorImagem = stringValue(sheet, ps, 9, i);
                            photo.setImageAuthor(autorImagem);
                            
                            // K - 10 - Data da Imagem
                            Calendar c = Calendar.getInstance();
                            c.set(Calendar.YEAR, intValue(sheet, ps, 10, i));
                            Date dataDaImagem = c.getTime();
                            photo.setDataCriacao(dataDaImagem);
                            
                            // L - 11 - Autor da Obra
                            String autorDaObra = stringValue(sheet, ps, 11, i);
                            photo.setWorkAuthor(autorDaObra);
                            
                            // M - 12 - Data da Obra
                            //Date dataDaObra = dateValue(sheet, ps, 12, i);
                            c = Calendar.getInstance();
                            c.set(Calendar.YEAR, intValue(sheet, ps, 12, i));
                            Date dataDaObra = c.getTime();
                            photo.setWorkdate(dataDaObra.toString());
                            
                            // N - 13 - Licença
                            String licenca = stringValue(sheet, ps, 13, i);
//                            if(licenca.equals("")) {
//                              ps.println(String.format("Copyright data not found at row %d.", i));
//                              throw new InvalidCellContents();
//                            }
//                            if(!licenca.contains(",")) {
//                                ps.println(String.format("Invalid copyright data at row %d: %s", i, licenca));
//                                throw new InvalidCellContents();
//                            }
//                            String allowCommercialUse = licenca.substring(0, licenca.indexOf(','));
//                            String allowModifications = licenca.substring(licenca.indexOf(',') + 1, licenca.length());
                            
                            //org.apache.xerces.dom.ElementNSImpl
                            // TODO
                            // photo.setAllowModifications
                            // photo.setAllowCommercialUses
                            
                            // O - 14 - Descrição
                            String descricao = stringValue(sheet, ps, 14, i);
                            photo.setDescription(descricao);
                            
                            // P - 15 - Tags Materiais
                            String tagsMateriais = stringValue(sheet, ps, 15, i);
                            
                            // Q - 16 - Tags Elementos
                            String tagsElementos = stringValue(sheet, ps, 16, i);
                            
                            // R - 17 - Tags Tipologia
                            String tagsTipologia = stringValue(sheet, ps, 17, i);
                            
                            // S - 18 - Observações
                            String observacoes = stringValue(sheet, ps, 18, i);
                            // TODO: where to put this?
                            
                            // T - 19 - Data de Catalogação
                            Date dataDeCatalogacao = dateValue(sheet, ps, 19, i);
                            photo.setCataloguingTime(dataDeCatalogacao);
                            
                            ps.println(String.format("row %d : %d - %s - %s (%s)", i, tombo, nome, pais, dataDeCatalogacao));
                            
                            System.out.println(System.currentTimeMillis() + ": Finished gathering data. Will save the photo object now...");
                            
                            photo.setCollablet(photoMgr);
                            photo.save();
                            photo.saveImage(new FileInputStream(imageFile));
                            
                            System.out.println(System.currentTimeMillis() + ": Photo object saved. Will save tags now...");
                            
// TAGS
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
                            
                            System.out.println(System.currentTimeMillis() + ": Tags saved.");
                            

// // OLD HACK                            
//                            String idName = Long.toHexString(i).toUpperCase();
//                            while(idName.length()<16)
//                                idName = "0" + idName;
//                            System.out.println(idName);
//                            for(String tagName : tagList) {
//                                String x = String.format("INSERT INTO gw_collab_Tag_Assignments SET className='br.org.groupwareworkbench.arquigrafia.photo.Photo', pk=0xACED00057372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870%s, Tag_id=(SELECT id FROM gw_collab_Tag WHERE name='%s');", idName, tagName);
//                                System.out.println(x);
//                            }
                            
                            
                        } catch (InvalidCellContents e) {
                        }
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
//                    if (!outputToStdout) {
                        ps.print(reportSuccessMessage);
                        ps.flush();
                        bos.flush();
                        fos.flush();
                        ps.close();
                        bos.close();
                        fos.close();
//                    }
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

    public String stringValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if(cell==null)
            return "";
        //System.err.println("s==============>" + columnNumber + ":" + cell.getStringValue());
        if (cell.getValueType()==null) {
            return "";
        }
        if (cell.getValueType().equals(CONTENT_STRING)) {
            return cell.getStringValue();
        }
        ps.println(String.format("Wrong data format in cell %c%d. Could not import row %d. This is the format: %s", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }
    
    public int intValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if(cell==null)
            return 0;
        //System.err.println("i==============>" + columnNumber + ":" + cell.getStringValue());
        if (cell.getValueType()==null) {
            return 0;
        }
        if (cell.getValueType().equals(CONTENT_FLOAT)) {
            return cell.getDoubleValue().intValue();
        }
        ps.println(String.format("Wrong data format in cell %c%d. Could not import row %d. This is the format: %s", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }
    
    public Date dateValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber-1);
        Cell cell = row.getCellByIndex(columnNumber);
        if(cell==null)
            return null;
        //System.err.println("d==============>" + columnNumber + ":" + cell.getStringValue());
        if (cell.getValueType()==null) {
            return null;
        }
        if (cell.getValueType().equals(CONTENT_DATE)) {
            return cell.getDateValue().getTime();
        }
        ps.println(String.format("Wrong data format in cell %c%d. Could not import row %d. This is the format: %s", 'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }
    
    public void recursiveSearchODS(ArrayList<File> list, File dir) {
        for (File file : dir.listFiles()) {
            String path = file.getAbsolutePath();
            System.out.println("Checking " + path);
            if (file.isFile() && path.toLowerCase().endsWith(".ods")) {
                String reportName = path.substring(0, path.length() - 3) + "report";
                File report = new File(reportName);
                if (!report.exists()) {
                    list.add(file);
                } else {
                    // Checking if the report reached the end.
                    try {
                        FileInputStream fis = new FileInputStream(report);
                        if (fis.available() > reportSuccessMessage.length() - 1) {
                            fis.skip(fis.available() - reportSuccessMessage.length() - 1);
                            byte[] b = new byte[reportSuccessMessage.length()];
                            fis.read(b);
                            if (!new String(b).equals(reportSuccessMessage)) {
                                list.add(file);
                            }
                        } else {
                            list.add(file);
                        }
                    } catch (FileNotFoundException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
            if(file.isDirectory()) {
                recursiveSearchODS(list, file);
            }
        }
    }
}