
package com.blackcode.sicefa.rest;

import com.blackcode.model.Producto;
import com.blackcode.sicefa.core.ControllerProductosCentral;
import com.google.gson.Gson;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

/**
 *
 * @author angel
 */
@Path("productosCentral")
public class RESTProductoCentral {

    @Path("getAll")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllProducts() {
        ControllerProductosCentral cp = new ControllerProductosCentral();
        List<Producto> productos = null;
        String out = null;
        Gson gson = new Gson();
        System.out.println("llege al rest de getAll");
        try {
            productos = cp.getAlls("");
            out = gson.toJson(productos);
        } catch (Exception e) {
            e.printStackTrace();
            out = "{\"exception\":" + e.toString().replaceAll("\"", "") + "\"}";
        }
        return Response.ok(out).build();
    }

    @Path("modificar")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response update(@FormParam("modificacionProductos") @DefaultValue("") String modificacionProductos) {
        Producto p = null;
        ControllerProductosCentral pu = new ControllerProductosCentral();
        String out = null;
        Gson gson = new Gson();
        System.out.println("llege al rest");
        System.out.println(modificacionProductos);
        try {
            gson = new Gson();
            p = gson.fromJson(modificacionProductos, Producto.class);
            pu.update(p);

            out = """
                {"response":"Datos de Producto Modificados correctamente"}
                """;
        } catch (Exception ex) {
            out = """
                {"response":"Ocurrio un error en el servidor. %S"}
                """;
            ex.getStackTrace();
            ex.printStackTrace();
        }
        return Response.ok(out).build();
    }

    @Path("eliminarProducto")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response borradoLogico(@FormParam("eliminacion") @DefaultValue("") String eliminacion) {
        Producto p = null;
        ControllerProductosCentral cpc = new ControllerProductosCentral();
        String out = "";
        Gson gson = null;
        System.out.println("llege al rest");
        System.out.println(eliminacion);
        try {
            gson = new Gson();
            p = gson.fromJson(eliminacion, Producto.class);
            if (p.getIdProducto() > 0) {
                cpc.borradoLogico(p);
            }
            out = """
                {"response":"Datos de Producto Modificados correctamente"}
                """;
        } catch (Exception e) {
            out = """
                {"response":"Ocurrio un error en el servidor. %S"}
                """;
            out = String.format(out, e.toString().replaceAll("\"", ""));
        }
        return Response.ok(out).build();
    }

    @Path("buscarProductoActivo")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response serachProductsByNameActive(@QueryParam("nombre") String nombre) {
        
        ControllerProductosCentral controller = new ControllerProductosCentral();
        Gson gson = new Gson();
        String out = null;

        try {
            // Crea un objeto Producto y asigna el nombre de búsqueda
            Producto producto = new Producto();
            producto.setNombre(nombre);

            // Llama al método para buscar productos activos por nombre
            controller.serachProductsByNameActive(producto);

            // Convierte el objeto Producto a JSON usando Gson
            out = gson.toJson(producto);

            // Devuelve la respuesta con el JSON
            return Response.ok(out).build();
        } catch (Exception e) {
            // Manejo de excepciones
            e.printStackTrace();
            out = """
            {"response":"Error en el servidor. %s"}
            """;
            out = String.format(out, e.toString().replaceAll("\"", ""));
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).entity(out).build();
        }
    }
}
