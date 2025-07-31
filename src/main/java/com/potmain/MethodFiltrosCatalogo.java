package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Pedido;
import models.Producto;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/MethodFiltrosCatalogo")
public class MethodFiltrosCatalogo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArrayList<Producto> productosBuscados = (ArrayList<Producto>) req.getSession().getAttribute("productosBuscados");
        String descripcion = req.getParameter("descripcion").toLowerCase();
        String marca = req.getParameter("marca").toLowerCase();
        String modelo = req.getParameter("modelo").toLowerCase();
        int precioMin = Integer.parseInt(req.getParameter("precioMin"));
        int precioMax = Integer.parseInt(req.getParameter("precioMax"));
        String termino = req.getParameter("termino").toLowerCase();
        ArrayList<Producto> productosEncontrados = new ArrayList<>();
        for(Producto producto : productosBuscados) {
            if (!descripcion.isEmpty()){
                if(producto.getDescripcion().toLowerCase().contains(descripcion) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
            }
            if(!marca.isEmpty()){
                if(producto.getMarca().toLowerCase().equals(marca) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
            }
            if(!modelo.isEmpty()){
                if(producto.getModelo().toLowerCase().equals(modelo) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
            }
            if(precioMin != 0 || precioMax != 0) {
                if(precioMin>precioMax){
                    if((producto.getPrecio()>precioMin) && !productosEncontrados.contains(producto))
                        productosEncontrados.add(producto);
                }else {
                    if(((producto.getPrecio()>precioMin) && (producto.getPrecio()<precioMax))
                            && !productosEncontrados.contains(producto)){
                        productosEncontrados.add(producto);
                    }
                }
            }
            if(!termino.isEmpty()){
                if(producto.getDescripcion().toLowerCase().contains(termino) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
                if(producto.getMarca().toLowerCase().contains(termino) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
                if(producto.getModelo().toLowerCase().contains(termino) && !productosEncontrados.contains(producto))
                    productosEncontrados.add(producto);
            }
        }
        req.getSession().setAttribute("productosBuscados", productosEncontrados);
        req.getRequestDispatcher("/verCatalogo.jsp?page=1").forward(req, resp);
    }
}
