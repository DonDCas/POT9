package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Admin;
import models.Controlador;
import models.Pedido;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Admin/guardarCambiosPedido")
public class guardarCambiosPedido extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        Controlador controlador = new Controlador();
        Admin admin = (Admin) req.getSession().getAttribute("user");
        Pedido copiaPedido = (Pedido) req.getSession().getAttribute("copiaPedido");
        Pedido pedidoElegido = (Pedido) req.getSession().getAttribute("pedidoElegido");
        PrintWriter out = resp.getWriter();
        out.println("<script>");
        if(controlador.clonarPedidoCopia(pedidoElegido, copiaPedido)){
            out.println("alert('¡Cambios Guardados!');");
        } else {
            out.println("alert('Error al guardar los cambios.');");
        }
        out.println("</script>");
        resp.sendRedirect("menuAdmin.jsp");
    }
}
