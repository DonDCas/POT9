package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Admin;
import models.Controlador;
import models.Trabajador;
import utils.Utils;
import utils.UtilsPass;

import java.io.IOException;

@WebServlet("/Admin/MethodAltaTrabajador")
public class MethodAltaTrabajador extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        Controlador controlador = new Controlador();
        Admin admin = (Admin) req.getSession().getAttribute("user");
        if (admin == null) {
            req.getSession().setAttribute("alerta", "ERROR GARRAFAL, USER INACTIVO, VOLVIENDO AL INICIO");
            resp.sendRedirect("index.jsp");
        }
        Trabajador trabajadorExistente = (Trabajador) req.getSession().getAttribute("trabajadorExistente");
        if (trabajadorExistente != null) {
            if (Utils.validaClave(req.getParameter("pass"))) {
                if (controlador.modificarDatosTrabajador(trabajadorExistente,UtilsPass.hash(req.getParameter("pass")),3)){
                    if (!controlador.darAltaTrabajador(trabajadorExistente)){
                        resp.sendRedirect("formularioAltaTrabajador.jsp?error=2");
                        return;
                    }else{
                        req.getSession().setAttribute("alerta", "Trabajador dado de alta, volviendo al menu");
                        resp.sendRedirect("menuAdmin.jsp");
                        return;
                    }
                }else{
                    resp.sendRedirect("formularioAltaTrabajador.jsp?error=2");
                    return;
                }
            }else{
                resp.sendRedirect("formularioAltaTrabajador.jsp?error=3");
                return;
            }
        }else{
            String correo = String.valueOf(req.getSession().getAttribute("correo"));
            String pass = String.valueOf(req.getSession().getAttribute("pass"));
            String nombre = String.valueOf(req.getSession().getAttribute("nombre"));
            int movil =  Integer.parseInt(String.valueOf(req.getSession().getAttribute("movil")));
            int idTelegram =  Integer.parseInt(String.valueOf(req.getSession().getAttribute("idTelegram")));
            req.getSession().removeAttribute("correo");
            req.getSession().removeAttribute("pass");
            req.getSession().removeAttribute("nombre");
            req.getSession().removeAttribute("numero");
            req.getSession().removeAttribute("idTelegram");
            if (!controlador.nuevoTrabajador(correo, pass, nombre, movil, idTelegram)){
                resp.sendRedirect("formularioAltaTrabajador.jsp?error=1");
                return;
            }else {
                req.getSession().setAttribute("alerta", "Trabajador nuevo registrado");
                resp.sendRedirect("formularioAltaTrabajador.jsp?error=2");
            }
        }
    }
}
