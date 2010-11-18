package br.org.groupwareworkbench.arquigrafia.tracker;

import br.com.caelum.vraptor.ioc.Component;

@Component
public class TrackRequest {
	private double longitude;
	private double latitude;
	private double range;
	
	public double getLongitude() {
		return longitude;
	}
	
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	
	public double getLatitude() {
		return latitude;
	}
	
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	
	public double getRange() {
		return range;
	}
	
	public void setRange(double range) {
		this.range = range;
	}
}
