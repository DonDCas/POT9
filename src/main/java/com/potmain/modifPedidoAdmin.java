package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Admin;
import models.Controlador;
import models.Pedido;
import utils.Utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;

import static java.lang.System.out;

@WebServlet("/Admin/modifPedidoAdmin")
public class modifPedidoAdmin extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Controlador controlador = new Controlador();
        Admin admin = (Admin) request.getSession().getAttribute("user");
        Pedido copiaPedido = (Pedido) request.getSession().getAttribute("copiaPedido");
        String parmEstado = request.getParameter("estado");
        int nuevoEstado = -1;
        try{
            nuevoEstado = Integer.parseInt(parmEstado);
        }catch(NumberFormatException e){
            nuevoEstado = -1;
        }
        String parmFecha = request.getParameter("fechaEstimada");
        LocalDate fechaEstimada = null;
        try {
            fechaEstimada = LocalDate.from(Utils.stringAFecha(parmFecha));
        } catch (Exception e) {
            fechaEstimada = null;
        }
        String parmComentario = request.getParameter("comentario");
        if(nuevoEstado != -1){
            if (controlador.cambiaEstadoPedido(copiaPedido, nuevoEstado)){
                request.getSession().setAttribute("alerta1", "¡Estado modificado!");
            } else {
                request.getSession().setAttribute("alerta1", "¡Estado no modificado!");
            }
        }
        if(fechaEstimada != null) {
            if (nuevoEstado != 4) {
                if (controlador.cambiaFechaPedido(copiaPedido, fechaEstimada)) {
                    request.getSession().setAttribute("alerta2", "¡Fecha modificada!");
                } else {
                    request.getSession().setAttribute("alerta2", "¡Fecha no modificada!");
                }
            } else {
                if (copiaPedido.getEstado() == 4) {
                    if (controlador.cambiaFechaPedido(copiaPedido, null)) {
                        request.getSession().setAttribute("alerta2", "¡Fecha modificada!");
                    } else {
                        request.getSession().setAttribute("alerta2", "¡Fecha no modificada!");
                    }
                } else{
                    if (controlador.cambiaFechaPedido(copiaPedido, null)){
                        request.getSession().setAttribute("alerta2", "¡Fecha modificada!");
                    } else {
                        request.getSession().setAttribute("alerta2", "¡Fecha no modificada!");
                    }
                }
            }
        }
        if (parmComentario != null && !parmComentario.isEmpty()){
            if (controlador.addComentario(copiaPedido, parmComentario)){
                request.getSession().setAttribute("alerta", "¡Comentario añadido!");
            } else {
                request.getSession().setAttribute("alerta", "¡Comentario no agregado!");
            }
        }
        request.getSession().setAttribute("copiaPedido", copiaPedido);
        request.getRequestDispatcher("seleccionPedidosAdmin.jsp?op=3&page=1").forward(request, response);
    }
}
