<%@ page import="java.util.ArrayList" %>
<%@ page import="models.*" %>
<%@ page import="utils.Utils" %><%--
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
    if (request.getSession().getAttribute("copiaPedido") != null) request.removeAttribute("copiaPedido");
    if (request.getSession().getAttribute("pedidoElegido") != null) request.removeAttribute("pedidoElegido");
    if (request.getSession().getAttribute("datosCliente") != null) request.removeAttribute("datosCliente");
    if (request.getSession().getAttribute("trabajadorAsignado") != null) request.removeAttribute("trabajadorAsignado");
    Admin admin = (Admin) user;
    ArrayList<Pedido> pedidos = new ArrayList<>();
    String parm = request.getParameter("op");
    String parm2 = request.getParameter("page");
    if (parm.equals("3")) pedidos = controlador.pedidosSinTrabajador();
    else pedidos = controlador.getTodosPedidos();
    int pages = 1;
    try {
        pages = Integer.parseInt(parm2);
    } catch (Exception e) {
        pages = 1;
    }
    int start = (pages - 1) * 5 +1;
    int end = Math.min(pedidos.size(), pages * 5)+1;
%>
<% if (session.getAttribute("alerta") != null) { %>
<script>alert('<%=session.getAttribute("alerta")%>');</script>
<%
        request.getSession().removeAttribute("trabajadorElegido");
        request.getSession().removeAttribute("alerta");
        request.getSession().removeAttribute("copiaPedido");
        request.getSession().removeAttribute("datosCliente");
        request.getSession().removeAttribute("pedidoElegido");
    }
%>
    <table border="2">
        <tr>
            <th colspan="2">
                Todos los pedidos
            </th>
        </tr>
        <%
            int index = 0;
            for(Pedido p : pedidos){
                index++;
                PedidoClienteDataClass datosCliente = controlador.getPedidoClienteUnico(p.getId());
                Trabajador trabajadorAsignado = controlador.buscaTrabajadorAsignadoAPedido(p.getId());
                if ((index <= pages*5) && index > (pages-1) * 5){
        %>
        <tr>
            <td>
                <a href="pedidoAdminElegido.jsp?op=<%=parm%>&idPedido=<%=p.getId()%>">
                id Pedido: <%=p.getId()%>
                </a>
            </td>
            <td>
                Cliente: <%=datosCliente.getNombreCliente()%>
            </td>
        </tr>
        <tr>
            <td>
                Fecha Pedido: <%=Utils.fechaAString(p.getFechaPedido())%>
            </td>
            <td>
                Estado: <%=p.getEstadoString()%>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Trabajador Asignado: <%=(trabajadorAsignado != null) ? trabajadorAsignado.getNombre() : "Sin trabajador asignado"%>
            </td>
        </tr>


        <%
            }
        }
            if((index % 5 == 0 && pages == index / 5) || pedidos.indexOf(pedidos.getLast()) == index-1){
        %>
        <tr>
            <td colspan="2">
                <% if (pages > 1) { %>
                <a href='seleccionPedidosAdmin.jsp?op=<%=parm%>&page=<%=(pages-1)%>'>Atrás</a>
                <% } %>
                <%= "Pedidos " + start + " a " + (end - 1) + " de " + pedidos.size() %>
                <% if (end < pedidos.size()) { %>
                <a href='seleccionPedidosAdmin.jsp?op=<%=parm%>&page=<%=(pages+1)%>'>Siguiente</a>
                <% } %>
            </td>
        </tr>
        <%
            }
        %>
        <tr>
            <td colspan="2">
                <a href='menuAdmin.jsp'>Volver al menu del admin</a>
            </td>
        </tr>
    </table>
</body>
</html>
