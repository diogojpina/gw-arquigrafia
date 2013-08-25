package br.org.groupwareworkbench.arquigrafia.photo;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.ioc.Component;
import br.org.groupwareworkbench.collablet.communic.tag.Tag;
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.Collablet;
import br.org.groupwareworkbench.core.search.StopwordException;
import br.org.groupwareworkbench.core.util.Pagination;

@Component
public class SearchOverall {
    
    private final Result result;
    private ResourceBundle bundle;

    
    public SearchOverall(Result result) {
        this.result = result;
        bundle = ResourceBundle.getBundle("messages");
    }

    public void all(PhotoMgrInstance photoMgr, final String q, Pagination pagination) {

        try {

            List<Tag> tags = Tag.searchByName(q, photoMgr.getCollablet().getDependency("tagMgr"));
    
            List<User> people = User.searchByName(q, new Collablet(8l, "userMgr"), pagination);
    
            Map<String, List<Photo>> photos = photoMgr.searchForAttributesOfThePhoto(q, pagination);
    
            result.include("tags", tags).include("people", people).include("photos", photos)
                    .include("results", photoMgr.hasResults(photos)).include("searchTerm", q);
            } catch(StopwordException se) {
                result.include("messageForStopword", MessageFormat.format(bundle.getString("search.stopword"), q));
            }
 
    }

    public void byAttribute(PhotoMgrInstance photoMgr, String term, String q, int page, int perPage) {
        List<Photo> results = photoMgr.searchForAttributeOfThePhoto(term, q, page, perPage);
        result.include("photos", results);
    }

}
