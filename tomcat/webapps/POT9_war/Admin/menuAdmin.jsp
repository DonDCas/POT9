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
  String alerta = String.valueOf(request.getSession().getAttribute("alerta"));
  if (alerta != "null") {
%>
    <script>
        alert("<%=alerta%>");
    </script>
<%
      request.getSession().removeAttribute("alerta");
  }
%>
<h1>Bienvenido, <%= admin.getNombre() %> tu ultima sesión fue: <%= lastSesion %> </h1>

<p>¿Que deseas hacer?</p>
<ul>
    <li><a href="../verCatalogo.jsp?page=1">Ver Catalogo</a></li>
    <li><a href="../verCatalogo.jsp?page=1&op=1">Editar Producto</a></li>
    <li><a href="seleccionClientes.jsp?page=1">Resumen de Clientes</a></li>
    <li><a href="seleccionPedidosAdmin.jsp?op=1&page=1">Resumen de Pedidos</a></li>
    <li><a href="seleccionTrabajador.jsp?op=1&page=1">Resumen de Trabajadores</a></li>
    <li><a href="estadisticasApp.jsp">Estadisticas de la aplicación</a></li>
    <li><a href="seleccionPedidosAdmin.jsp?op=2&page=1">Cambiar estado de un pedido</a></li>
    <li><a href="formularioAltaTrabajador.jsp">Dar de alta a un trabajador</a></li>
    <li><a href="seleccionTrabajador.jsp?op=2&page=1">Dar de baja a un trabajador</a></li>
    <li><a href="seleccionPedidosAdmin.jsp?op=3&page=1">Asignar un Pedido a un Trabajador</a></li>
    <li><a href="UltimosInicios.jsp">Últimos inicios de sesión de Usuarios</a></li>
    <li><a href="ExportarExcel.jsp">Exportar pedidos en Excel</a></li>
    <li><a href="copiasSeguridad.html">Realizar copia de seguridad de la app</a></li>
    <li><a href="consultarRutas.jsp">Consultar Rutas de configuración de la app</a></li>
    <li><a href="modifInvitado.jsp">Modificar modo Invitado</a></li>
    <li><a href="../methodslogout.jsp">Cerrar Sesión</a></li>
</ul>
</body>
</html>
