package br.org.groupwareworkbench.arquigrafia.photo.transformations;

import java.io.IOException;

import br.org.groupwareworkbench.core.graphics.GWImage;
import br.org.groupwareworkbench.core.graphics.ImageTransformation;

public class Thumb implements ImageTransformation {

    @Override
    public String name() {
        return "thumb";
    }

    @Override
    public GWImage transform(GWImage image) throws IOException {
        return image.doTheBestYouCanToFitOnRectangle(105, 72);
    }

}
