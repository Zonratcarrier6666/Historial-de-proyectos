
package com.blackcode.sicefa.rest;

import com.blackcode.model.Ejemplo;
import com.blackcode.model.Empleado;
import com.blackcode.model.Sucursal;
import com.google.gson.Gson;
import com.blackcode.sicefa.core.ControllerEmpleado;
import com.blackcode.sicefa.core.ControllerSucursal;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

/**
 *
 * @author Esme
 */
@Path("empleado")
public class RestEmpleado {
    @Path("save")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
                       //Por que viene desde el internet: @FormParam
   public Response save(@FormParam("datosEmpleados")  @DefaultValue("")String datosEmpleado){
        System.out.println(datosEmpleado);
       Empleado emp = null;
       ControllerEmpleado ce = new ControllerEmpleado();
       String out= null;
       Gson gson = new Gson();
       
       try{
           emp = gson.fromJson(datosEmpleado, Empleado.class);
          
           if(emp.getId()< 1){
               ce.insert(emp);
           }
           else{
               System.out.println("aaaa");
               ce.update(emp);
           }
           out= """
                {"result":"Datos de empleado gruardados correctamente."}
                """;
           } 
       catch(Exception ex)
       {
           ex.printStackTrace();
           out= """
                {"exception":"Ocurrio un error en el servidor. %S"}
        
                """;
           
           out = String.format(out, ex.toString().replaceAll("\"", ""));
           System.out.println(out);
       }
       
       return Response.ok(out).build();
   }
   
   
    @Path("getAll")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAll(){
        ControllerEmpleado ce= new ControllerEmpleado();
        List<Empleado> empleados = null;
        String out=null;
        Gson gson = new Gson();
        
        try{
            empleados = ce.getAll("");
            out = gson.toJson(empleados);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            out="{\"exception\":" + e.toString().replaceAll("\"", "")+"\"}";
        }
        return Response.ok(out).build();
    }
    
    @Path("insertEjemplo")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response insertEjemplo(@FormParam("datosEjemplo") @DefaultValue("") String datos){
        String out = "";
        Gson gson = null;
        ControllerEmpleado cp = new ControllerEmpleado();
        Ejemplo e = null;
        
        try {
            gson = new Gson();
            e = gson.fromJson(datos, Ejemplo.class);
            cp.insertEjemplo(e);
            out = """
                  {"response" : "Registro insertado"}
                  """;
        } catch (Exception ex) {
            out = """
                  {"response" : "Error al insertar"}
                  """;
            ex.getStackTrace();
        }
        
        return Response.ok(out).build();
    }
    
    @Path("eliminarEmpleado")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response borradoLogico(@FormParam("eliminacion") @DefaultValue("") String eliminacion) {
        Empleado e = null;
        ControllerEmpleado em = new ControllerEmpleado();
        String out = "";
        Gson gson = null;
                System.out.println("llege al rest");
         System.out.println(eliminacion);
        try {
            gson = new Gson();
            e = gson.fromJson(eliminacion, Empleado.class);
            if (e.getId() > 1) {
                System.out.println("Puga wey");
              em.delete(e);
            }
            out = """
                {"response":"Datos de Producto Modificados correctamente"}
                """;
        } catch (Exception ex) {
            out = """
                {"response":"Ocurrio un error en el servidor. %S"}
                """;
            out = String.format(out, ex.toString().replaceAll("\"", ""));
        }
        return Response.ok(out).build();
    }
    
}
