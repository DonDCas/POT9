package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Controlador;
import utils.Utils;

import java.io.*;

@WebServlet("/MethodDescargarBackUp")
public class MethodDescargarBackUp extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Controlador controlador = new Controlador();

        // Crea la copia de seguridad en una ubicación temporal

        File archivoBackup = controlador.exportaCopiaDeSegridad("");

        if (archivoBackup != null && archivoBackup.exists()) {
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=" + archivoBackup.getName());
            response.setContentLength((int) archivoBackup.length());

            try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(archivoBackup));
                 BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {

                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                response.sendRedirect("menuAdmin.jsp");
            }
        } else {
            response.getWriter().println("No se pudo generar la copia de seguridad.");
            Utils.veteADormir();
            response.sendRedirect("menuAdmin.jsp");
        }
    }
}
