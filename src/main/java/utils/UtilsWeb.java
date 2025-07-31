package utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Admin;
import models.Cliente;
import models.Trabajador;

import java.io.IOException;

public class UtilsWeb {
    public static void usuarioNull(Object user, HttpServletRequest request, HttpServletResponse response, String redireccion) throws ServletException, IOException {
        if(user == null){
            request.getSession().setAttribute("alerta", "ERROR GARRAFAL VOLVIENDO AL INICIO");
            request.getRequestDispatcher(redireccion).forward(request,response);
            return;
        }
    }

    public static void volverIndexError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("alerta", "ERROR GARRAFAL, VOLVIENDO AL INICIO");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    public static void volverMenuError(Object user, HttpServletRequest request, HttpServletResponse response, String mensajeError) throws ServletException, IOException {
        if (user instanceof Admin) {
            request.getSession().setAttribute("alerta", mensajeError);
            request.getRequestDispatcher("Admin/menuAdmin.jsp").forward(request, response);
            return;
        }
        if (user instanceof Trabajador) {
            request.getSession().setAttribute("alerta", mensajeError);
            request.getRequestDispatcher("Trabajador/menuTrabajador.jsp").forward(request, response);
            return;
        }
        if (user instanceof Cliente) {
            request.getSession().setAttribute("alerta", mensajeError);
            request.getRequestDispatcher("Cliente/menuCliente.jsp").forward(request, response);
            return;
        }
    }

    public static void preparaAlerta(HttpServletRequest request, String mensajeAlerta) {
        request.getSession().setAttribute("alerta", mensajeAlerta);
    }
}
