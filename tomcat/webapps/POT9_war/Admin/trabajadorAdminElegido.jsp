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
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    Admin admin = (Admin) user;
    String parm = request.getParameter("op");
    int op = 0;
    try{
        op = Integer.parseInt(parm);
    } catch (NumberFormatException e) {
        op = -1;
    }
    String idTrabajador = request.getParameter("idTrabajador");
    Trabajador trabajadorElegido = controlador.buscaTrabajadorByID(idTrabajador);
    ArrayList<Pedido> pedidosAsignados = controlador.recuperaPedidosAsignadosTrabajador(trabajadorElegido);
    request.getSession().setAttribute("trabajadorElegido", trabajadorElegido);
    if (op == 1){
        %>
Aqui tienes el Trabajador/a Elegido <br>
        <%}else{
        if (op > 1) {
        %>
¿Es este el trabajador/a deseado?<br>
<%
        }
    }
    if (op>=1){
%>
<table border="2">
    <tr>
        <th colspan="5">
            <br>
            Trabajador Elegido ID: <%=trabajadorElegido.getId()%>
            <br><br>
        </th>
    </tr>
    <tr>
        <td>
            Nombre trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getNombre()%>
        </td>
    </tr>
    <tr>
        <td>
            Movil trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getMovil()%>
        </td>
    </tr>
    <tr>
        <td>
            Email trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getCorreo()%>
        </td>
    </tr>
    <tr>
        <td>
            Id telegram del trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getIdTelegram()%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos asignados
        </td>
        <td colspan="3"></td>
        <td>
            <%=pedidosAsignados.size()%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos Pendientes
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getPedidosPendientes(pedidosAsignados).size()%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos completados
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorElegido.getPedidosCompletados(pedidosAsignados).size()%>
        </td>
    </tr>
</table>
<a href="seleccionTrabajador.jsp?op=<%=parm%>&page=1">Volver la selección de trabajadores</a>
<br>
<%
    if((op == 2) && admin!=null) {
%>
<a href="<%= request.getContextPath() %>/Admin/trabajadorAdminElegido">Dar de baja a este trabajador</a>
<br>
<%
    }
%>
<%
    if((op == 3) && admin != null) {
%>
<a href="seleccionPedidosAdmin.jsp?op=<%=parm%>&page=1">Volver a la selección de pedidos</a>
<br>
<a href="/adjudicarPedido">Terminar adjudicación del pedido</a>
<br>
<%
    }
%>
<%
    }
%>
</body>
</html>
