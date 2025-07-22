package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Controlador;

import java.io.IOException;

@WebServlet("/MethodGuardarEnRutaDefault")
public class MethodGuardarEnRutaDefault extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Controlador controlador = new Controlador();
        controlador.exportaCopiaDeSegridad("");
        response.getWriter().println("Copia de seguridad guardada en la ruta predeterminada.");
        response.sendRedirect("menuAdmin.jsp");
    }
}
