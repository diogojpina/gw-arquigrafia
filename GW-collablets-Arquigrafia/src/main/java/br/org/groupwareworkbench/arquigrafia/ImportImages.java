package br.org.groupwareworkbench.arquigrafia;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
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

    public static final String reportSuccessMessage =
            "End of report - Magic number: 34793824710238213265489543932033346583\n";

    public static final String CONTENT_BOOLEAN = "boolean";
    public static final String CONTENT_CURRENCY = "currency";
    public static final String CONTENT_DATE = "date";
    public static final String CONTENT_FLOAT = "float";
    public static final String CONTENT_PERCENTAGE = "percentage";
    public static final String CONTENT_STRING = "string";
    public static final String CONTENT_TIME = "time";

    public void run() throws Exception {
        FileOutputStream fileOutputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        PrintStream printStream = null;

        try {
            String now = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(new Date());

            String importDirName = "/home/gw/imports/";

            File importDir = new File(importDirName);
            verifyValidDir(importDirName, importDir);

            ArrayList<File> odsFiles = new ArrayList<File>();
            recursiveSearchODS(odsFiles, importDir);
            System.out.println("--------------> ODS Files: " + odsFiles);

            File reportDir = new File("/home/gw/importReports");
            if (!reportDir.exists()) {
                reportDir.mkdir();
            }

            fileOutputStream = new FileOutputStream(new File(String.format("/home/gw/importReports/import_report_%s.txt", now)));
            bufferedOutputStream = new BufferedOutputStream(fileOutputStream, BUFFER_SIZE);
            printStream = new PrintStream(bufferedOutputStream);
            printStream.println(String.format("Import report (%s) - Automatically generated.", now));

            for (File odsFile : odsFiles) {
                try {
                    printStream.println();
                    printStream.println(String.format(
                            "########################################################### FILE %s", odsFile
                                    .getAbsolutePath()));
                    FileInputStream fileInputStream = new FileInputStream(odsFile);

                    // Creates the OK file
                    {
                        String okFileName =
                                odsFile.getCanonicalPath().substring(0, odsFile.getCanonicalPath().lastIndexOf('.')) +
                                        ".ok";
                        File okFile = new File(okFileName);
                        if (okFile.exists()) {
                            printStream.println();
                            printStream.println("\t!!!!! WARNING: OK file exists. Skipping this spreadsheet. !!!!!!!!");
                            continue;
                        }
                        
                        okFile.createNewFile();
                    }
                    
                    importSheet(fileInputStream, printStream, odsFile);

                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    printStream.println();
                    printStream.println();
                    printStream.println("###########################################################");
                    printStream.println("###########################################################");
                    printStream.println(reportSuccessMessage);
                    printStream.println();
                    printStream.flush();
                    bufferedOutputStream.flush();
                    fileOutputStream.flush();
                }
            }

        } catch (IOException e) {
            System.err.println("FATAL ERROR: Could not even write to error file.");
            e.printStackTrace();
        } finally {
            printStream.close();
            bufferedOutputStream.close();
            fileOutputStream.close();
        }
    }

    private void importSheet(FileInputStream inputStream, PrintStream printStream, File odsFile) throws Exception {

        SpreadsheetDocument currentDocument = SpreadsheetDocument.loadDocument(inputStream);
        Table sheet = currentDocument.getSheetByIndex(0);

        Collablet tagMgr = Collablet.findByName("tagMgr");
        Collablet photoMgr = Collablet.findByName("photoMgr");
        
        Collablet userMgr = Collablet.findByName("userMgr");
        User user = User.findByLogin("acervofau", userMgr, AccountType.NATIVE);
        if (user == null) {
            throw new Exception(
                    "User acervofau does not exist!!!! Cannot import any image. Please make sure this user exists before trying to import images.");
        }

        /*
         * We simply throw away the first row, which may be used to hold column labels. It is easier to use the indexes
         * 1, 2, 3... for table rows, since this is the standard used in spreadsheets. Therefore, we will always refer
         * to the row according to this standard. On the other hand, getRow needs the row number to start in zero. So we
         * correct the call to getRow using i-1 instead of i.
         */
        int rowCount = sheet.getRowCount();
        System.out.println("################> " + rowCount);
        for (int i = 2; i <= rowCount + 1 && !sheet.getCellByPosition(0, i - 1).getStringValue().equals(""); i++) {
            System.out.println("-------------------------------------------");
            System.out.println(System.currentTimeMillis() + ": Importing row " + i);
            try {

                printStream.println();
                printStream.println(String.format("========================== (row %d)", i));
                printStream.println();

                importPhoto(sheet, printStream, i, user, odsFile, photoMgr, tagMgr);

                printStream.println();
                printStream.println("\t#### SUCCESS #### (:P)");
            } catch (InvalidCellContents e) {
                printStream.println("\tInvalid cell contents: " + e.getLocalizedMessage());
            } catch (Exception e) {
                printStream.println("\tUnknown exception: " + e.getLocalizedMessage());
            } finally {
                printStream.flush();
            }
        }
    }

    private void importPhoto(Table sheet, PrintStream printStream, int rowNumber, User user, File odsFile, Collablet photoMgr, Collablet tagMgr) throws InvalidCellContents, RuntimeException, IOException {
        // A - 0 - Tombo
        String tombo = stringValue(sheet, printStream, 0, rowNumber, true).trim();

        printStream.println();
        printStream.println(String.format("\tTombo: %s", tombo));
        printStream.println();

        Photo photo = Photo.findByTombo(tombo);
        boolean newPhoto;
        if (photo == null) {
            printStream.println("\tCREATING");
            photo = new Photo();
            newPhoto = true;
        } else {
            printStream.println("\tUPDATING");
            newPhoto = false;
        }

        printStream.println();

        photo.assignUser(user);

        String fileName = tombo + ".jpg";
        // Checking if the file exists. If it doesn't, give it up right now.
        File imageFile = new File(odsFile.getParentFile().getCanonicalPath() + "/" + fileName);
        if (!imageFile.exists()) {
            if (newPhoto) {
                printStream.println(String.format("\tFATAL: File %s NOT FOUND. Giving up importing %d.",
                        imageFile, tombo));
                return;
            }
            // else
            printStream.print(String.format(
                    "\tINFO: File %s NOT FOUND, but that is OK since we are just updating an image.",
                    imageFile, tombo));
        }
        photo.setNomeArquivo(fileName);
        photo.setTombo(tombo);

        // B - 1 - Caracterização

        // C - 2 - Nome
        String name = stringValue(sheet, printStream, 2, rowNumber, true);
        photo.setName(name);

        // D - 3 - País
        String country = stringValue(sheet, printStream, 3, rowNumber, true);
        photo.setCountry(country);

        // E - 4 - Estado
        String state = stringValue(sheet, printStream, 4, rowNumber, true);
        photo.setState(state);

        // F - 5 - Cidade
        String city = stringValue(sheet, printStream, 5, rowNumber, true);
        photo.setCity(city);

        // G - 6 - Bairro
        String neighborhood = stringValue(sheet, printStream, 6, rowNumber, true);
        photo.setDistrict(neighborhood);

        // H - 7 - Rua
        String street = stringValue(sheet, printStream, 7, rowNumber, true);
        photo.setStreet(street);

        // I - 8 - Coleção
        String collection = stringValue(sheet, printStream, 8, rowNumber, true);
        photo.setCollection(collection);

        // J - 9 - Autor da Imagem
        String author = stringValue(sheet, printStream, 9, rowNumber, true);
        photo.setImageAuthor(author);

        // K - 10 - Data da Imagem
        String dataCriacao = stringValue(sheet, printStream, 10, rowNumber, false);
        if (!dataCriacao.trim().equalsIgnoreCase("null")) {
            try {
                photo.setDataCriacao(new ISO8601(dataCriacao));
            } catch (ISO8601ViolationException e) {
                printStream
                        .println(String
                                .format(
                                        "\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data da obra.",
                                        dataCriacao, 'A' + 10, rowNumber));
            }
        }

        // L - 11 - Autor da Obra
        String workAuthor = stringValue(sheet, printStream, 11, rowNumber, true);
        if (workAuthor.trim().equalsIgnoreCase("null")) {
            photo.setWorkAuthor(null);
        } else {
            photo.setWorkAuthor(workAuthor);
        }

        // M - 12 - Data da Obra
        String workDate = stringValue(sheet, printStream, 12, rowNumber, true);
        try {
            photo.setWorkdate(new ISO8601(workDate));
        } catch (ISO8601ViolationException e) {
            printStream
                    .println(String
                            .format(
                                    "\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data da obra.",
                                    workDate, 'A' + 12, rowNumber));
        }


        // N - 13 - Licença
        String license = stringValue(sheet, printStream, 13, rowNumber, true).trim();
        validateAndSetLicense(printStream, rowNumber, photo, license);

        // O - 14 - Descrição
        String description = stringValue(sheet, printStream, 14, rowNumber, true);
        photo.setDescription(description);

        // P - 15 - Tags Materiais
        String tagsMateriais = stringValue(sheet, printStream, 15, rowNumber, true);

        // Q - 16 - Tags Elementos
        String tagsElementos = stringValue(sheet, printStream, 16, rowNumber, true);

        // R - 17 - Tags Tipologia
        String tagsTipologia = stringValue(sheet, printStream, 17, rowNumber, true);

        // S - 18 - Observações
        String comments = stringValue(sheet, printStream, 18, rowNumber, true);
        photo.setAditionalImageComments(comments);
        // TODO: where to put this?

        // T - 19 - Data de Catalogação
        String dataCatalogacao = stringValue(sheet, printStream, 19, rowNumber, false);
        try {
            photo.setCataloguingTime(new ISO8601(dataCatalogacao));
        } catch (ISO8601ViolationException e) {
            printStream
                    .println(String
                            .format(
                                    "\tWARNING: String \"%s\" (cell %c%d) is not a valid ISO8601, so I will not set data de catalogacao.",
                                    dataCatalogacao, 'A' + 19, rowNumber));
        }

        printStream.println("\tINFO: Saving data to database:");
        printStream.flush();

        photo.setCollablet(photoMgr);
        photo.save();
        if (imageFile.exists()) {
            photo.saveImage(new FileInputStream(imageFile));
        }

        printStream.println(String.format("\t\t       Nome = %s", name));
        printStream.println(String.format("\t\t       Pais = %s", country));
        printStream.println(String.format("\t\tD. Catalog. = %s", dataCatalogacao));
        printStream.println(String.format("\t\t   Image ID = %d", photo.getId()));

        System.out.println("\tPhoto object saved. Will save tags now...");
        String tags = tagsMateriais + "," + tagsElementos + "," + tagsTipologia;
        setTags(tagMgr, photo, tags);        
    }

    private void setTags(Collablet tagMgr, Photo photo, String allTags) {
        String tags = allTags;
        while (tags.contains(",")) {
            String tagName = tags.substring(0, tags.indexOf(','));
            tagName = tagName.trim();
            if (!tagName.equals("")) {
                Tag tag = Tag.findByName(tagName, tagMgr);
                if (tag == null) {
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
    }

    private void validateAndSetLicense(PrintStream printStream, int rowNumber, Photo photo, String license)
            throws InvalidCellContents {
        if (license.equals("")) {
            printStream.println(String.format("\tFATAL: Copyright data not found at row %d.", rowNumber));
            throw new InvalidCellContents();
        }
        if (!license.contains("-")) {
            printStream.println(String.format(
                    "\tFATAL: Invalid copyright data at row %d: %s. This cell should have a hyphen character.",
                    rowNumber, license));
            throw new InvalidCellContents();
        }
        try {
            AllowCommercialUses allowCommercialUses =
                    AllowCommercialUses
                            .valueOf(license.substring(0, license.indexOf('-')).toUpperCase().trim());
            AllowModifications allowModifications =
                    AllowModifications.valueOf(license.substring(license.indexOf('-') + 1, license.length())
                            .toUpperCase().trim());
            photo.setAllowCommercialUses(allowCommercialUses);
            photo.setAllowModifications(allowModifications);
        } catch (Exception e) {
            /*
             * If anything happens, especially if an IllegalArgumentException happens (which means there was a
             * problem parsing a string to an enumeration value in the Enumeration.valueOf method), we abort the
             * import of this row.
             */
            printStream
                    .println(String
                            .format(
                                    "\tFATAL: Error reading copyright data. This is the data from the spreadsheet: \"%s\" and this is the exception message: \"%s\"",
                                    license, e.getMessage()));
            throw new InvalidCellContents();
        }
    }

    private void verifyValidDir(String importDir, File dir) {
        if (!dir.exists()) {
            throw new IllegalArgumentException(importDir + " does not exist. Giving up.");
        }
        if (!dir.isDirectory()) {
            throw new IllegalArgumentException(importDir + " is not a directory. Giving up.");
        }
    }

    public String removeAllWhiteSpace(String string) {
        return string.replaceAll("\\S", "");
    }

    public String stringValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber, boolean logError)
            throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber - 1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell == null) {
            return "";
        }
        if (cell.getValueType() == null) {
            return "";
        }
        if (cell.getValueType().equals(CONTENT_FLOAT) || cell.getValueType().equals(CONTENT_STRING) ||
                cell.getValueType().equals(CONTENT_DATE)) {
            return cell.getStringValue();
        }
        if (logError) {
            ps
                    .println(String
                            .format(
                                    "\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but should be \"string\".",
                                    'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        }
        throw new InvalidCellContents();
    }

    public int intValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber - 1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell == null) {
            return 0;
        }
        if (cell.getValueType() == null) {
            return 0;
        }
        if (cell.getValueType().equals(CONTENT_FLOAT)) {
            return cell.getDoubleValue().intValue();
        }
        ps
                .println(String
                        .format(
                                "\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but should be \"int\".",
                                'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }

    public Date dateValue(Table sheet, PrintStream ps, int columnNumber, int rowNumber) throws InvalidCellContents {
        Row row = sheet.getRowByIndex(rowNumber - 1);
        Cell cell = row.getCellByIndex(columnNumber);
        if (cell == null) {
            return null;
        }
        if (cell.getValueType() == null) {
            return null;
        }
        if (cell.getValueType().equals(CONTENT_DATE)) {
            return cell.getDateValue().getTime();
        }
        ps
                .println(String
                        .format(
                                "\tFATAL: Wrong data format in cell %c%d. Could not import row %d. The format is \"%s\", but shoud be \"date\".",
                                'A' + columnNumber, rowNumber, rowNumber, cell.getValueType()));
        throw new InvalidCellContents();
    }

    public void recursiveSearchODS(ArrayList<File> list, File dir) {
        for (File file : dir.listFiles()) {
            String path = file.getAbsolutePath();
            if (file.isFile() && path.toLowerCase().endsWith(".ods")) {
                list.add(file);
            }
            if (file.isDirectory()) {
                recursiveSearchODS(list, file);
            }
        }
    }
}