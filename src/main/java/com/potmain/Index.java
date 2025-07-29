package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import persistencia.Persistencia;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@WebServlet("/inicio")
public class Index extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        Properties pro = Persistencia.iniciaPropertiesModif();
        boolean resultado = Boolean.parseBoolean(pro.getProperty("modoInvitado"));
        if (resultado){
            response.sendRedirect(request.getContextPath() + "/inicioa.html");
        }
        else{
            response.sendRedirect(request.getContextPath() + "/iniciob.html");
        }

    }
}
