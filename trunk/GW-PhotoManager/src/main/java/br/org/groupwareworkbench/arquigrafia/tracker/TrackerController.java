/*
*    UNIVERSIDADE DE SÃO PAULO.
*    Author: Marco Aurélio Gerosa (gerosa@ime.usp.br)
*    This project was/is sponsored by RNP and FAPESP.
*
*    This file is part of Groupware Workbench (http://www.groupwareworkbench.org.br).
*
*    Groupware Workbench is free software: you can redistribute it and/or modify
*    it under the terms of the GNU Lesser General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    Groupware Workbench is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU Lesser General Public License for more details.
*
*    You should have received a copy of the GNU Lesser General Public License
*    along with Swift.  If not, see <http://www.gnu.org/licenses/>.
*/
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
import br.org.groupwareworkbench.collablet.coord.user.User;
import br.org.groupwareworkbench.core.framework.MainCollablet;

@RequestScoped
@Resource
public class TrackerController {

    private Result result;
	private Validator validator;

	public TrackerController(final Validator validator, final Result result){
		this.result = result;
		this.validator = validator;
	}
	
	private void addIncludes(TrackerInstance trackerInstance){
        result.include(trackerInstance.getCollablet().getName(), trackerInstance);
        trackerInstance.getCollablet().includeDependencies(result);
        result.include(MainCollablet.getMainCollablet().getName(), MainCollablet.getMainCollablet().getBusinessObject());
        MainCollablet.getMainCollablet().includeDependencies(result);
	}
	
	@Get
	@Path("/groupware-workbench/tracker/{trackerInstance}")
	public void index(TrackerInstance trackerInstance){
	    double defaultLatitude = Double.parseDouble(trackerInstance.getCollablet().getProperty("defaultLatitude"));
	    double defaultLongitude = Double.parseDouble(trackerInstance.getCollablet().getProperty("defaultLongitude"));
	    double defaultRange = Double.parseDouble(trackerInstance.getCollablet().getProperty("defaultRange"));
	    result.forwardTo(this).list(trackerInstance, defaultLatitude, defaultLongitude, defaultRange);
	}
	
    @Get
	@Path("/groupware-workbench/tracker/{trackerInstance}/list/{lat}/{lng}/{range}")
	public List<TrackingInfo> list(TrackerInstance trackerInstance, double lat, double lng, double range){
		TrackRequest track = new TrackRequest();
		track.setLatitude(lat);
		track.setLongitude(lng);
		track.setRange(range);
		
		addIncludes(trackerInstance);
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
