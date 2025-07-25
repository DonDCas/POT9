package com.potmain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Controlador;

import java.io.*;

@WebServlet("/Admin/importarBackup")
@MultipartConfig
public class ImportarBackup extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int dontLogin = 0;
        dontLogin = Integer.parseInt(request.getParameter("dontLogin"));
        Controlador controlador = new Controlador();
        Part filePart = request.getPart("RutaBackUpImport");
        String fileName = filePart.getSubmittedFileName();
        File archivoTemp = File.createTempFile("backup_", ".sql");
        archivoTemp.deleteOnExit();

        try (InputStream input = filePart.getInputStream();
             OutputStream output = new FileOutputStream(archivoTemp)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }

        boolean exito = controlador.importarCopiaDeSeguridad(archivoTemp.getAbsolutePath());

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<script>");
        if (exito) {
            out.println("alert('¡Importación realizada con éxito!');");
        } else {
            out.println("alert('Error al importar la copia de seguridad.');");
        }
        if (dontLogin != 1)  out.println("window.location.href = 'menuAdmin.jsp';");
        else out.println("window.location.href = '../index.jsp';");
        out.println("</script>");
    }
}
