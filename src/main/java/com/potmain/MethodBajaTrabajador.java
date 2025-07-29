package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Admin;
import models.Controlador;
import models.Trabajador;

import java.io.IOException;

@WebServlet("/Admin/trabajadorAdminElegido")
public class MethodBajaTrabajador extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Admin admin = (Admin) req.getSession().getAttribute("user");
        Trabajador trabajadorElegido = (Trabajador) req.getSession().getAttribute("trabajadorElegido");
        Controlador controlador = new Controlador();
        if(admin == null){
            req.getSession().setAttribute("alerta", "ERROR GARRAFAL, No se pudo realizar la operación," +
                    "Volviendo al inicio.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }else{
            if (trabajadorElegido != null){
                if(controlador.quitarPedidosAsignados(trabajadorElegido,
                        controlador.recuperaPedidosAsignadosTrabajador(trabajadorElegido))){
                    if(controlador.darBajaTrabajador(trabajadorElegido)){
                        req.getSession().setAttribute("alerta", "Trabajador dado de baja.");
                    }else {
                        req.getSession().setAttribute("alerta", "No se dio de baja al trabajador. " +
                                "Revisar sus pedidos asignados.");
                    }
                }else{
                    req.getSession().setAttribute("alerta", "No se dio de baja al trabajador. " +
                            "Revisar sus pedidos asignados.");
                }
                req.getRequestDispatcher("seleccionTrabajador.jsp?op=2&page=1").forward(req, resp);
            }else{
                req.getSession().setAttribute("alerta", "ERROR GARRAFAL, No se pudo realizar la operación," +
                        "Volviendo al inicio.");
                req.getRequestDispatcher("/index.jsp").forward(req, resp);

            }
        }
    }
}
