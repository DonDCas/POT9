package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Controlador;
import models.Producto;
import utils.UtilsWeb;

import java.io.IOException;

@WebServlet("/MethodModifProducto")
public class MethodModifProducto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Controlador controlador = new Controlador();
        Producto productoElegido = (Producto) request.getSession().getAttribute("productoElegido");
        String opBrowser = request.getParameter("op");
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("guardar")) {
                controlador.ModificaProduto(productoElegido);
                UtilsWeb.preparaAlerta(request, "Producto modificado correctamente, volviendo a la seleccion de Productos.");
                request.getSession().removeAttribute("productosBuscados");
                request.getRequestDispatcher("verCatalogo.jsp?page=1"+opBrowser).forward(request, response);
                return;
            }else if (action.equals("descartar")) {
                UtilsWeb.preparaAlerta(request, "Se han descartado los cambios, volviendo a la seleccion de Productos.");
                request.getSession().removeAttribute("productosBuscados");
                request.getRequestDispatcher("verCatalogo.jsp?page=1"+opBrowser).forward(request, response);
                return;
            }
        }
        String nuevaMarca = request.getParameter("marca");
        String nuevoModelo = request.getParameter("modelo");
        String nuevaDescripcion = request.getParameter("descripcion");
        float nuevaPrecio = productoElegido.getPrecio();
        try{
            nuevaPrecio = Float.parseFloat(request.getParameter("precio"));
        }catch(NumberFormatException e){
            UtilsWeb.preparaAlerta(request, "Se introdujo el precio de forma incorrecta");
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        }
        int nuevaRelevancia = Integer.parseInt(request.getParameter("relevancia"));
        if(controlador.editarProducto(productoElegido, nuevaMarca,
                nuevoModelo, nuevaDescripcion, nuevaPrecio, nuevaRelevancia)){
            UtilsWeb.preparaAlerta(request, "Datos Modificados correctamente. Recuerda Guardar los Cambios");
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            return;
        }else{
            UtilsWeb.preparaAlerta(request, "No se pudo modificar los cambios");
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            return;
        }
    }
}
