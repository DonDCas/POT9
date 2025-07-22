<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %><%--
  Created by IntelliJ IDEA.
  User: dondc
  Date: 09/07/2025
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
    <title> Practica Obligatoria Tema 9</title>
    </head>
    <body>
    <script>
        function descargarYRedirigir() {
            document.getElementById("iframeDescarga").src = "DescargarBackUpServlet";
            setTimeout(() => {
                window.location.href = "menuAdmin.jsp";
            }, 3000);
        }
    </script>
        <form method="post" action="MethodGuardarEnRutaDefault">
            <button type="submit">Guardar en ruta predeterminada (servidor)</button>
        </form>

        <br>

        <form method="get" action="MethodDescargarBackUp">
            <button onclick="descargarYRedirigir()">Descargar y volver al menú</button>
            <iframe id="iframeDescarga" style="display:none;"></iframe>
        </form>
    </body>
</html>
