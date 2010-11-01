package br.org.groupwareworkbench.collablet.coop.album;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.tests.DatabaseTester;
import br.org.groupwareworkbench.tests.Fruit;
import br.org.groupwareworkbench.tests.GWRunner;

@RunWith(GWRunner.class)
public class AlbumMgrInstanceTest {
    private AlbumMgrInstance albumInstance;
    private Collablet c;
    @Before
    public void setUp() {
        c = new Collablet("cool Collablet");
        albumInstance = new AlbumMgrInstance(c);
    }

    @Test
    public void testNotNullGetDefaultAlbumbyUserNull(){
     
        Album a = albumInstance.getAlbumByDefault(new User());
        Assert.assertNotNull(a);
    }
}
