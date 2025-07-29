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
    String parm = request.getParameter("op");
    String parm2 = request.getParameter("page");
    int op = 0;
    try{
        op = Integer.parseInt(parm);
    } catch (NumberFormatException e) {
        op = -1;
    }
    ArrayList<Trabajador> trabajadores = controlador.getTrabajadoresDeAlta();
    int pages = 1;
    try {
        pages = Integer.parseInt(parm2);
    } catch (Exception e) {
        pages = 1;
    }
    int start = (pages - 1) * 5 +1;
    int end = Math.min(trabajadores.size(), pages * 5)+1;
    int index = 0;
%>
<%
    for (Trabajador t : trabajadores){
        index++;
        ArrayList<Pedido> pedidosAsignados = controlador.recuperaPedidosAsignadosTrabajador(t);
        if ((index <= pages*5) && index > (pages-1) * 5){
%>
<table>
    <tr>
        <th colspan="2">Lista de trabajadores</th>
    </tr>
    <tr>
        <td>
            ID Trabajador:
        </td>
        <td>
            <a href="trabajadorAdminElegido.jsp?op=<%=op%>&idTrabajador=<%=t.getId()%>">
                <%=t.getId()%>
            </a>
        </td>
    </tr>
    <tr>
        <td>
            Nombre
        </td>
        <td>
            <%=t.getNombre()%>
        </td>
    </tr>
    <tr>
        <td>
            Email
        </td>
        <td>
            <%=t.getCorreo()%>
        </td>
    </tr>
    <tr>
        <td>
            Nº Pedidos Pendientes
        </td>
        <td>
            <%=t.getPedidosPendientes(pedidosAsignados).size()%>
        </td>
    </tr>
    <tr>
        <td>
            Nº Pedidos Asignados
        </td>
        <td>
            <%=pedidosAsignados.size()%>
        </td>
    </tr>
<%
        }
    }
%>
    <tr>
        <td colspan="2">
            <% if (pages > 1) { %>
            <a href='seleccionTrabajador.jsp.jsp?op=<%=parm%>&page=<%=(pages-1)%>'>Atrás</a>
            <% } %>
            <%= "Trabajadores " + start + " a " + (end - 1) + " de " + trabajadores.size() %>
            <% if (end < trabajadores.size()) { %>
            <a href='seleccionTrabajador.jsp?op=<%=parm%>&page=<%=(pages+1)%>'>Siguiente</a>
            <% } %>
        </td>
    </tr>
    <tr>
        <%
            if (op != 3){
        %>
        <td colspan="2">
            <a href='menuAdmin.jsp'>Volver al menu del admin</a>
        </td>
        <%
        }
        else {
        %>
        <td >
            <a href='menuAdmin.jsp'>Volver al menu del admin</a>
        </td>
        <td>
            <a href='seleccionPedidosAdmin.jsp?op=3&page=1'>Seleccionar otro pedido</a>
        </td>
        <%
            }
        %>
    </tr>
</table>
</body>
</html>