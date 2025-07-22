<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: dondc
  Date: 09/07/2025
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.Part" %>
<html>
<head>
    <title>Practica Obligatoria Tema 9</title>
</head>
    <body>
        <%
            try {
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
            if (controlador.importarCopiaDeSeguridad(archivoTemp.getAbsolutePath())){
                archivoTemp.deleteOnExit();%>
            <script>
                alert("Nene que ha funcionado!");
                window.location.href="menuAdmin.jsp";
            </script>
        <%}else{
            archivoTemp.deleteOnExit();%>
            <script>
                alert("Nene que no ha funcionado! Volvemos al menu de Admin");
                window.location.href="menuAdmin.jsp";
            </script>
        <%}
        } catch (Exception e) {
        %>
        <script>
            alert("Error: <%= e.getMessage() %>");
            window.location.href = "menuAdmin.jsp";
        </script>
        <%
            }
        %>
    </body>
</html>