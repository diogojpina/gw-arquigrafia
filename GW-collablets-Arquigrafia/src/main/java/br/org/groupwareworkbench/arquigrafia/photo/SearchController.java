package br.org.groupwareworkbench.arquigrafia.photo;

import java.util.List;
import java.util.Map;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.core.RequestInfo;
import br.com.caelum.vraptor.view.Results;
import br.org.groupwareworkbench.core.util.Pagination;

@Resource
public class SearchController {

    
    private final Result result;
    private final Validator validator;
    private final SearchOverall search;
    private final RequestInfo requestInfo;
    private final Analytics analytics;

    
    public SearchController(SearchOverall search, Result result, Validator validator, RequestInfo requestInfo,
            Analytics analytics) {
        this.result = result;
        this.validator = validator;
        this.search = search;
        this.requestInfo = requestInfo;
        this.analytics = analytics;
    }

    @Path("/analytics")
    public void analytics(String q) {
        analytics.save(q);
    }
    
    @Get
    @Path(value = "/photo/{photoMgr}/search/all")
    public void search(PhotoMgrInstance photoMgr, final String q) {

        List<Photo> photos = photoMgr.searchForAttributeOfThePhoto("name", q, 1, 20);

        result.use(Results.representation())
            .from(photos, "photos")
            .exclude("id", "nomeArquivo", "dataUpload", "deleted")
            .serialize();
    }


//    @SuppressWarnings("unchecked")
//    @Get
//    @Path(value = "/photo/{photoMgr}/list")
//    public void busca(PhotoMgrInstance photoMgr) {
//        addIncludes(photoMgr);
//
//        // FIXME: adicionar a condição do header accepts-content
//        // Melhor seria achar um jeito do vRaptor reportar esse estado, ao invés da aplicação refazer essa checagem
//        boolean xmlRequest;
//        try {
//            xmlRequest = "xml".equals(requestInfo.getRequest().getParameter("_format"));
//        } catch (Exception e) {
//            xmlRequest = false;
//        }
//
//        if (xmlRequest) {
//            result.use(Results.representation()).from((List<Photo>) result.included().get("fotos")).serialize();
//        } else {
//            result.of(this).busca(photoMgr);
//        }
//    }
//
//    private void addIncludes(PhotoMgrInstance photoMgr) {
//        result.include(photoMgr.getCollablet().getName(), photoMgr);
//        photoMgr.getCollablet().includeDependencies(result);
//    }
//
//    @Post
//    @Path(value = "/photo/{photoMgr}/search")
//    public void search(PhotoMgrInstance photoMgr, final String q, int page, int perPage) {
//
//        validate(photoMgr, q);
//        search.all(photoMgr, q, new Pagination(page, perPage));
//        result.use(logic()).forwardTo(PhotoController.class).busca(photoMgr);
//    }
//
//    private void validate(PhotoMgrInstance photoMgr, final String q) {
//        validator.checking(new Validations() {
//            {
//                that(q.length() > 0, "length", "search.length");
//            }
//        });
////        validator.onErrorForwardTo(this).busca(photoMgr);
//    }
//
//    @Get
//    @Path("/photos/{photoMgr}/search/term")
//    public void searchByAttribute(PhotoMgrInstance photoMgr, String term, String q, int page, int perPage) {
//        List<Photo> results = photoMgr.searchForAttributeOfThePhoto(term, q, page, perPage);
//        result.include("photos", results);
//        addIncludes(photoMgr);
//    }
//
//    @Get
//    @Path("/photos/{photoMgr}/counts/search/term")
//    public void countsPhotosSearchByAttribute(PhotoMgrInstance photoMgr, String term) {
//        String q = WrapperEncoderParam.decode(term);
//        Map<String, Long> results = photoMgr.countsPhotosSearchByAttribute(q);
//        result.use(Results.json()).withoutRoot().from(results).serialize();
//    }
//
//    @Get
//    @Path("/photos/{photoMgr}/show/search/term") 
//    public void showSearchByAttribute(PhotoMgrInstance photoMgr, String term, String q, int page, int perPage) {
//        String search = WrapperEncoderParam.decode(q);
//        List<Photo> results = photoMgr.searchForAttributeOfThePhoto(term, search, page, perPage);
//        result.include("photos", results).include("term", term).include("searchTerm", search);
//        addIncludes(photoMgr);
//    }
//
//
//    @Get
//    @Path("/photos/{photoMgr}/count/search/term")
//    public void countPhotosSearchByAttribute(PhotoMgrInstance photoMgr, String term, String q) {
//        String search = WrapperEncoderParam.decode(q);
//        Long count = photoMgr.countPhotosSearchByAttribute(term, search);
//        result.use(Results.json()).withoutRoot().from(count).serialize();
//    }
    
    
    

}
