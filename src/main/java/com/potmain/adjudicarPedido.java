package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Controlador;
import models.Pedido;
import models.Trabajador;

import java.io.IOException;

@WebServlet("/Admin/adjudicarPedido")
public class adjudicarPedido extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        Controlador controlador = new Controlador();
        Trabajador trabajadorElegio = (Trabajador) req.getSession().getAttribute("trabajadorElegido");
        Pedido pedidoElegido = (Pedido) req.getSession().getAttribute("pedidoElegido");
        if (trabajadorElegio != null) {
            if (controlador.asignaPedido(pedidoElegido.getId(), trabajadorElegio.getId()))
                req.getSession().setAttribute("alerta", "Pedido Asignado al trabajador.");
            else
                req.getSession().setAttribute("alerta", "Pedido No Asignado al trabajador.");
        }else
            req.getSession().setAttribute("alerta", "Pedido No Asignado al trabajador.");
        req.getRequestDispatcher("seleccionPedidosAdmin.jsp?op=3&page=1").forward(req, resp);
    }
}
