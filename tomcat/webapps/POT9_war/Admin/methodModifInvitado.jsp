<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %><%--
  Created by IntelliJ IDEA.
  User: dondc
  Date: 21/07/2025
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Practica Obligatoria Tema 9</title>
</head>
<body>
<%
    Controlador controlador = new Controlador();
    Admin user = (Admin) request.getSession().getAttribute("user");
    controlador.modificaModoInvitado((controlador.modoInvitado() ? "false" : "true"));
%>
    <script>
        alert("Modificación realizada. Ahora el Modo Invitado esta <%= controlador.modoInvitado() ? "activado" : "desactivado" %>");
        window.location.href = "menuAdmin.jsp";
    </script>
</body>
</html>
