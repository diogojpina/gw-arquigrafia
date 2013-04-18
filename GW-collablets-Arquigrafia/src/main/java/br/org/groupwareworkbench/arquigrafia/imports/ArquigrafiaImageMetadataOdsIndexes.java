package br.org.groupwareworkbench.arquigrafia.imports;

public enum ArquigrafiaImageMetadataOdsIndexes {

    TOMBO("Tombo",0),
    CARACTERIZACAO("Caracterização",1),
    NOME("Nome",2),
    PAIS("País",3),
    ESTADO("Estado",4),
    CIDADE("Cidade",5),
    BAIRRO("Bairro",6),
    RUA("Rua",7),
    COLECAO("Coleção",8),
    AUTOR_IMAGEM("Autor da Imagem",9),
    DATA_IMAGEM("Data da Imagem",10),
    AUTOR_OBRA("Autor da Obra",11),
    DATA_OBRA("Data da Obra",12),
    LICENCA("Licença",13),
    DESCRICAO("Descrição",14),
    TAG_MATERIAIS("Tags Materiais",15),
    TAG_ELEMENTOS("Tags Elementos",16),
    TAG_TIPOLOGIA("Tags Tipologia",17),
    OBSERVACOES("Observações",18),
    DATA_TOMBO("Data de Tombo",19),
    DATA_CATALOGACAO("Data de Catalogação",20);
    
    private final String title;
    private final int columnIndex;
    
    private ArquigrafiaImageMetadataOdsIndexes(String title, int columnIndex) {
        this.title = title;
        this.columnIndex = columnIndex;
    }
    
    public int getColumnIndex() {
        return columnIndex;
    }
    
    public String getTitle() {
        return title;
    }
    
}
