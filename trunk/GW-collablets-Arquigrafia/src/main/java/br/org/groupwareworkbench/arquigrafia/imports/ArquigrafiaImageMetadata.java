package br.org.groupwareworkbench.arquigrafia.imports;

import java.io.File;
import java.lang.reflect.Field;

public class ArquigrafiaImageMetadata {

    public static ArquigrafiaImageMetadata fromRow(String resourcepath, String[] arrayRowValues) {
        
        ArquigrafiaImageMetadata arquigrafiaMetadataImage = new ArquigrafiaImageMetadata();
        
        for (ArquigrafiaImageMetadataOdsIndexes index : ArquigrafiaImageMetadataOdsIndexes.values()){
            try {
                Field fieldFromIndex = ArquigrafiaImageMetadata.class.getDeclaredField(index.name());
                fieldFromIndex.set(arquigrafiaMetadataImage, arrayRowValues[index.getColumnIndex()] );
            }
            catch (Exception ex) {
                System.out.println(String.format("%s on field %s", "Error setting value on image metadata instance.", index.getTitle() ) );
                ex.printStackTrace();
            }
        }
        
        arquigrafiaMetadataImage.resourcePath = resourcepath;
        
        return arquigrafiaMetadataImage;
    }
    
    public String TOMBO = "";
    public String CARACTERIZACAO = "";
    public String NOME = "";
    public String PAIS = "";
    public String ESTADO = "";
    public String CIDADE = "";
    public String BAIRRO = "";
    public String RUA = "";
    public String COLECAO = "";
    public String AUTOR_IMAGEM = "";
    public String DATA_IMAGEM = "";
    public String AUTOR_OBRA = "";
    public String DATA_OBRA = "";
    public String LICENCA = "";
    public String DESCRICAO = "";
    public String TAG_MATERIAIS = "";
    public String TAG_ELEMENTOS = "";
    public String TAG_TIPOLOGIA = "";
    public String OBSERVACOES = "";
    public String DATA_TOMBO = "";
    public String DATA_CATALOGACAO = "";
    
    public String resourcePath;
    
    public String getFileName() {
        return String.format("%s.jpg", this.TOMBO);
    }
    
    public File getImageFile() {
        File newTeste = new File(resourcePath);
        File imageFile = new File(newTeste, getFileName());
        return imageFile;
    }

}
