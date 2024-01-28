/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.blackcode.sicefa.rest;

import com.blackcode.model.Cliente;
import com.blackcode.sicefa.core.ControllerCliente;
import com.google.gson.Gson;
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
@Path("cliente")
public class RESTCliente {
    @Path("save")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
                       //Por que viene desde el internet: @FormParam
   public Response save(@FormParam("datosCliente")  @DefaultValue("")String datosCliente){
       
       Cliente clientes = null;
       ControllerCliente cc = new ControllerCliente();
       String out= null;
       Gson gson = new Gson();
       
        System.out.println("llegue al rest");
        System.out.println(datosCliente);
       try{
           clientes = gson.fromJson(datosCliente, Cliente.class);
          
           if(clientes.getIdCliente() < 1){
               cc.insert(clientes);
           }
           else{
               cc.update(clientes);
           }
           out= """
                {"result":"Datos de cliente guardados correctamente."}
                """;
           } 
       catch(Exception ex)
       {
           ex.printStackTrace();
           out= """
                {"exception":"Ocurrio un error en el servidor. %S"}
        
                """;
           
           out = String.format(out, ex.toString().replaceAll("\"", ""));
       }
       
       return Response.ok(out).build();
   }
   
    
    @Path("getAll")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAll(){
        ControllerCliente cc = new ControllerCliente();
        List<Cliente> clientes = null;
        String out = null;
        Gson gson = new Gson();
        
        try{
            clientes = cc.getAll("");
            out = gson.toJson(clientes);
        } catch (Exception e){
            e.printStackTrace();
            out = "{\"exception\":" + e.toString().replaceAll("\"","") + "\"}";
        }
        return Response.ok(out).build();
    }
    
    
    @Path("eliminarCliente")
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response borradoLogico(@FormParam("eliminacion") @DefaultValue("") String eliminacion) {
        Cliente c = null;
        ControllerCliente cl = new ControllerCliente();
        String out = "";
        Gson gson = null;
                System.out.println("llege al rest");
         System.out.println(eliminacion);
        try {
            gson = new Gson();
            
            c = gson.fromJson(eliminacion, Cliente.class);
            
            if (c.getIdCliente()> 0) {
                
                System.out.println("Puga wey");
               cl.deleteCliente(c);
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
    
}
