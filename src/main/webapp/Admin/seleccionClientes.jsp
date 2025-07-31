<%@ page import="java.util.ArrayList" %>
<%@ page import="models.*" %>
<%@ page import="utils.Utils" %>
<%@ page import="data.DataIVA" %><%--
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
    if (request.getSession().getAttribute("alerta")!=null) {
%>
    <script>
        alert(<%=request.getSession().getAttribute("alerta")%>)
    </script>
<%
        request.getSession().removeAttribute("alerta");
    }
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    Admin admin = (Admin) user;
    Utils.usuarioNull(admin, request,response,"../index.jsp");
    ArrayList<Cliente> clientes = controlador.getClientes();
    int pages = 1;
    String parm = request.getParameter("page");
    try {
        pages = Integer.parseInt(parm);
    } catch (Exception e) {
        pages = 1;
    }
    int start = (pages - 1) * 5 +1;
    int end = Math.min(clientes.size(), pages * 5)+1;
    int index = 0;
%>
Selecciona el cliente que deseas ver
<%
    for (Cliente c : clientes){
        index++;
        if ((index <= pages*5) && index > (pages-1) * 5){
%>
<table>
    <tr>
        <th colspan="2">Lista de Clientes</th>
    </tr>
    <tr>
        <td>
            ID Cliente:
        </td>
        <td>
            <a href="clienteAdminElegido.jsp?idCliente=<%=c.getId()%>">
                <%=c.getId()%>
            </a>
        </td>
    </tr>
    <tr>
        <td>
            Nombre
        </td>
        <td>
            <%=c.getNombre()%>
        </td>
    </tr>
    <tr>
        <td>
            Localidad
        </td>
        <td>
            <%=c.getLocalidad()%>(<%=c.getProvincia()%>)
        </td>
    </tr>
    <tr>
        <td>
            Nº Pedidos de pedidos
        </td>
        <td>
            <%=c.getPedidos(controlador).size()%>
        </td>
    </tr>
<%
        }
    }
%>
    <tr>
        <td colspan="2">
            <% if (pages > 1) { %>
            <a href='seleccionClientes.jsp?page=<%=(pages-1)%>'>Atrás</a>
            <% } %>
            <%= "Clientes " + start + " a " + (end - 1) + " de " + clientes.size() %>
            <% if (end < clientes.size()) { %>
            <a href='seleccionClientes.jsp?page=page=<%=(pages+1)%>'>Siguiente</a>
            <% } %>
        </td>
    </tr>
        <td >
            <a href='menuAdmin.jsp'>Volver al menu del admin</a>
        </td>
    </tr>
</table>
</body>
</html>