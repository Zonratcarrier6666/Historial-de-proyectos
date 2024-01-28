package com.blackcode.sicefa.rest;

//import com.blackcode.sicefa.core.ControllerInventario;
import com.blackcode.sicefa.core.ControllerInventario;
import com.blackcode.model.Inventario;
import com.google.gson.Gson;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("inventario")

public class RESTInventario {

    @Path("getAll")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
  
    public Response getALL() {
        ControllerInventario ci = new ControllerInventario();
        List<Inventario> inventarios = null;
        String out = null;
        Gson gson = new Gson();

        try {
            inventarios = ci.getAll("");
            out = gson.toJson(inventarios);
        } catch (Exception e) {
            e.printStackTrace();
            out = "{\"exception\":" + e.toString().replaceAll("\"", "") + "\"}";
        }
        return Response.ok(out).build();
    }
    


}
