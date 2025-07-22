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
    <title>Practica Obligatoria Tema 9</title>
</head>
<body>
<%
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    Admin admin = (Admin) user;
%>
<h1>El modo invitado se encuentra actualmente como: <%=controlador.modoInvitado() ? "Activado" : "Desactivado"%> ¿Que deseas hacer?</h1>
<button onclick="window.location.href='methodModifInvitado.jsp'"><%=controlador.modoInvitado() ? "Desactivar" : "Activar"%></button><button onclick="window.location.href='menuAdmin.jsp'">Volver</button>

</body>
</html>
