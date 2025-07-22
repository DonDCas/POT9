<%@ page import="models.Controlador" %>
<%@ page import="models.Cliente" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Admin" %>
<%@ page import="models.Trabajador" %><%--
  Created by IntelliJ IDEA.
  User: usuario
  Date: 22/07/2025
  Time: 12:31
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
%>
<table>
  <tr>
    <th colspan="4">
      <h4>¿Que inicios de sesión quieres ver?</h4>
    </th>
  </tr>
  <tr>
    <td>
      <a href="UltimosInicios.jsp?op=1">Todos los usuarios</a>
    </td>
    <td>
      <a href="UltimosInicios.jsp?op=2">Solo Clientes</a>
    </td>
    <td>
      <a href="UltimosInicios.jsp?op=3">Solo Trabajadores</a>
    </td>
    <td>
      <a href="UltimosInicios.jsp?op=4">Solo Admins</a>
    </td>
  </tr>
</table>
<br><br><br>
  <%
  String opc = "";
  opc = request.getParameter("op");
  %>
<table>
  <%
    if (opc != null){
      if (opc.equalsIgnoreCase("1") || (opc.equalsIgnoreCase("4"))){
        ArrayList<Admin> admins = controlador.getAdmins();
        for(Admin a : admins){
  %>
  <tr>
    <td>
      <%=a.getId()%>
    </td>
    <td>
      <%=a.getNombre()%>
    </td>
    <td>
      <%=a.getCorreo()%>
    </td>
    <td>
      <%=controlador.recuperarInicioSesion(a)%>
    </td>
  </tr>
  <%
    }
      }
    if (opc.equalsIgnoreCase("1") || opc.equalsIgnoreCase("3")){
      ArrayList<Trabajador> trabajadores = controlador.getTrabajadoresDeAlta();
      for(Trabajador t : trabajadores){
    %>
      <tr>
        <td>
          <%=t.getId()%>
        </td>
        <td>
          <%=t.getNombre()%>
        </td>
        <td>
          <%=t.getCorreo()%>
        </td>
        <td>
          <%=controlador.recuperarInicioSesion(t)%>
        </td>
      </tr>
      <%
      }
    }
    if (opc.equalsIgnoreCase("1") || opc.equalsIgnoreCase("2")){
        ArrayList<Cliente> clientes = controlador.getClientes();
        for(Cliente c : clientes){
  %>
    <tr>
      <td>
        <%=c.getId()%>
      </td>
      <td>
        <%=c.getNombre()%>
      </td>
      <td>
        <%=c.getCorreo()%>
      </td>
      <td>
        <%=controlador.recuperarInicioSesion(c)%>
      </td>
    </tr>
    <%}
    }
  }
  %>
</table>
<a href="menuAdmin.jsp"><button>Volver</button></a>
</body>
</html>
