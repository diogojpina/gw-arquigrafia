package br.org.groupwareworkbench.arquigrafia.imports;

import java.lang.reflect.Field;

public class ArquigrafiaImageMetadata {

    public static ArquigrafiaImageMetadata fromRow(String[] arrayRowValues) {
        
        ArquigrafiaImageMetadata arquigrafiaMetadataImage = new ArquigrafiaImageMetadata();
        Field[] existentMetadataEntries = ArquigrafiaImageMetadata.class.getDeclaredFields();
        for ( Field selectedEntry : existentMetadataEntries ) {
            try {
                ArquigrafiaImageMetadataOdsIndexes selectedIndex = ArquigrafiaImageMetadataOdsIndexes.valueOf(selectedEntry.getName());
                selectedEntry.set(arquigrafiaMetadataImage, arrayRowValues[selectedIndex.getColumnIndex()] );
            }
            catch (Exception ex) {
                System.out.println(String.format("%s on field %s", "Error setting value on image metadata instance.", selectedEntry.getName() ) );
                ex.printStackTrace();
            }
        }
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

}
