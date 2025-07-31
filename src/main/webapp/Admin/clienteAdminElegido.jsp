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
    Utils.usuarioNull(user, request, response, "../index.jsp");
    int op = 0;
    try{
        op = Integer.parseInt(parm);
    } catch (NumberFormatException e) {
        op = -1;
    }
    String idCliente = request.getParameter("idCliente");
    Cliente clienteElegido = controlador.buscaClienteById(idCliente);
    ArrayList<Pedido> pedidosCliente = clienteElegido.getPedidos(controlador);
        %>
Aqui tienes el Trabajador/a Elegido <br>

<table border="2">
    <tr>
        <th colspan="2">
            <br>
            Cliente elegido ID: <%=clienteElegido.getId()%>
            <br><br>
        </th>
    </tr>
    <tr>
        <td>
            Nombre Cliente
        </td>
        <td>
            <%=clienteElegido.getNombre()%>
        </td>
    </tr>
    <tr>
        <td>
            Movil Cliente
        </td>
        <td>
            <%=clienteElegido.getMovil()%>
        </td>
    </tr>
    <tr>
        <td>
            Email Cliente
        </td>
        <td>
            <%=clienteElegido.getCorreo()%>
        </td>
    </tr>
    <tr>
        <td>
            Direccion del CLiente
        </td>
        <td>
            <%=clienteElegido.getDireccion()%> - <%=clienteElegido.getLocalidad()%>(<%=clienteElegido.getProvincia()%>)
        </td>
    </tr>
    <tr>
        <td>
            Total Pedidos realizados
        </td>
        <td>
            <%=pedidosCliente.size()%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos Pendientes
        </td>
        <td>
            <%=pedidosCliente.size()%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos En Proceso
        </td>
        <td>
            <%=controlador.numPedidosSoloCreados(pedidosCliente) + controlador.numPedidosEnPreparacion(pedidosCliente)%>
        </td>
    </tr>
    <tr>
        <td>
            Numero Pedidos Cancelados
        </td>
        <td>
            <%=controlador.numPedidosCancelados(pedidosCliente)%>
        </td>
    </tr>
</table>
<a href="seleccionClientes.jsp?page=1">Volver la selección de Clientes</a>
<br>
<a href="menuAdmin.jsp">Volver al menu principal</a>
</body>
</html>
