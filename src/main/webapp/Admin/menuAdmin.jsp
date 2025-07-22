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
  String lastSesion = controlador.recuperarInicioSesion(user);
%>
<h1>Bienvenido, <%= admin.getNombre() %> tu ultima sesión fue: <%= lastSesion %> </h1>

<p>¿Que deseas hacer?</p>
<ul>
    <li>Ver Catalogo</li>
    <li>Editar Producto</li>
    <li>Resumen de Clientes</li>
    <li>Resumen de Trabajadores</li>
    <li>Ver Estadisticas de la aplicación</li>
    <li>Cambiar estado de un pedido</li>
    <li>Dar de alta a un trabajador</li>
    <li>Dar de baja a un trabajador</li>
    <li>Asignar un Pedido a un Trabajador</li>
    <li><a href="UltimosInicios.jsp">Últimos inicios de sesión de Usuarios</a></li>
    <li><a href="ExportarExcel.jsp">Exportar pedidos en Excel</a></li>
    <li><a href="copiasSeguridad.html">Realizar copia de seguridad de la app</a></li>
    <li><a href="consultarRutas.jsp">Consultar Rutas de configuración de la app</a></li>
    <li><a href="modifInvitado.jsp">Modificar modo Invitado</a></li>
    <li><a href="../methodslogout.jsp">Cerrar Sesión</a></li>
</ul>
</body>
</html>
