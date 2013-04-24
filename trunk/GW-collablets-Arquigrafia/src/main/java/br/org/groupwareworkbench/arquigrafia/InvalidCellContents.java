package br.org.groupwareworkbench.arquigrafia;

public class InvalidCellContents extends Exception {

    private static final long serialVersionUID = 1L;
    
    public InvalidCellContents() {
        super();
    }
    
    public InvalidCellContents(String message) {
        super(message);
    }

}
