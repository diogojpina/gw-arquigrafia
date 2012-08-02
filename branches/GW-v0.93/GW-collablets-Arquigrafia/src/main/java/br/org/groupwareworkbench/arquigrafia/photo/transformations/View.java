package br.org.groupwareworkbench.arquigrafia.photo.transformations;

import java.io.IOException;

import br.org.groupwareworkbench.core.graphics.GWImage;
import br.org.groupwareworkbench.core.graphics.ImageTransformation;

public class View implements ImageTransformation {

    @Override
    public String name() {
        return "view";
    }

    @Override
    public GWImage transform(GWImage image) throws IOException {
        if(image.getWidth() > 600) {
            return image.scaleToWidth(600);
        }
        
        return image;
    }

}
