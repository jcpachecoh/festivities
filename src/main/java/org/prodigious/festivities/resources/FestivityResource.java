package org.prodigious.festivities.resources;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.prodigious.festivities.model.Festivity;
import org.prodigious.festivities.service.FestivityService;

@Path("/festivities")
public class FestivityResource {
	FestivityService festservice=new FestivityService();
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Festivity addFestivity(Festivity fest){
		return festservice.addFestivity(fest);
	}
	
	@PUT
	@Path("/{festivityId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Festivity deleteFestivity(@PathParam("festivityId") long id){
		return festservice.removeFestivity(id);
	}
	
	@PUT
	@Path("/{festivityId}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Festivity updateFestivity(@PathParam("festivityId")long id, Festivity fest){
		fest.setId(id);
		return festservice.updateFestivity(fest);
	}
	
	
	@GET
	@Path("/{festivityId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Festivity getFestivity(@PathParam("festivityId") long id){
		return festservice.getFestivity(id);
	}
	
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Festivity> getFestivities(){
		return festservice.getallFestivities();
	}
	
}
