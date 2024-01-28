package com.blackcode.sicefa.rest;

import come.blackcode.sicefa.core.ControllerLogin;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * @author marko
 */
@Path("login")

public class RESTLogin {

    @Path("vc")
    @Produces(MediaType.APPLICATION_JSON)
    @GET
    public Response login(
            @QueryParam("nombreUsuario") @DefaultValue("") String nombreUsuario,
            @QueryParam("contrasenia") @DefaultValue("") String contrasenia) {

        String mensaje;

        ControllerLogin controller = new ControllerLogin();

        if (!controller.login(nombreUsuario, contrasenia)) {
            mensaje = """
                        {"response":"Credenciales incorrectas"}
                      """;
        } else {
            mensaje = """
                        {"response":"Credenciales correctas"}
                      """;
        }
        return Response.status(Response.Status.OK).entity(mensaje).build();
    }
}
