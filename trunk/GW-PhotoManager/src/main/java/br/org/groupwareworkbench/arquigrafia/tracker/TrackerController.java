package br.org.groupwareworkbench.arquigrafia.tracker;

import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.org.groupwareworkbench.arquigrafia.photo.PhotoMgrInstance;
import br.org.groupwareworkbench.collablet.coord.user.User;

@RequestScoped
@Resource
public class TrackerController {
    private static final double defaultLatitude = -23.558764;
    private static final double defaultLongitude = -46.731850;
    private static final double defaultRange = 5; //in kilometers
    
	private Result result;
	private Validator validator;

	public TrackerController(final Validator validator, final Result result){
		this.result = result;
		this.validator = validator;
	}
	
	@Get
	@Path("/groupware-workbench/tracker/{trackerInstance}")
	public void index(TrackerInstance trackerInstance){
	    result.forwardTo(this).list(trackerInstance, defaultLatitude, defaultLongitude, defaultRange);
	}
	
	@SuppressWarnings("cast") //cast de Business para PhotoMgrInstance
    @Get
	@Path("/groupware-workbench/tracker/{trackerInstance}/list/{lat}/{lng}/{range}")
	public List<TrackingInfo> list(TrackerInstance trackerInstance, double lat, double lng, double range){
		TrackRequest track = new TrackRequest();
		track.setLatitude(lat);
		track.setLongitude(lng);
		track.setRange(range);
		
		result.include("tracker", trackerInstance);
        result.include("photoMgr", (PhotoMgrInstance)trackerInstance.getCollablet().getParent().getBusinessObject());
		result.include("trackRequest", track);
		return trackerInstance.listAllInRange(lat, lng, range);
	}
	
	@Post
	@Path("/groupware-workbench/tracker/{trackerInstance}/update")
	public void update(TrackingInfo trackingInfo, TrackerInstance trackerInstance, User user){
		//Validação das coordenadas
		if(Math.abs(trackingInfo.getLatitude()) > 90){
			validator.add(new ValidationMessage("Latitude inválida.", "Dados inválidos"));
		}
		if(Math.abs(trackingInfo.getLongitude()) > 180){
			validator.add(new ValidationMessage("Longitude inválida.", "Dados inválidos"));
		}
		//Validação da acuidade
		if(trackingInfo.getAccuracy() > 1000){
			validator.add(new ValidationMessage("Acuidade inválida.", "Dados inválidos"));
		}
		
		validator.onErrorUsePageOf(this).update(trackingInfo, trackerInstance, user);
		
		trackingInfo.setUser(user);
		trackerInstance.save(trackingInfo);
	}
}
