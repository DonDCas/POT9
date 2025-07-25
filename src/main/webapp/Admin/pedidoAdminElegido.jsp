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
    String idPedido = request.getParameter("idPedido");
    Pedido pedidoElegido = controlador.buscaPedidoById(idPedido);
    PedidoClienteDataClass datosCliente = controlador.getPedidoClienteUnico(pedidoElegido.getId());
    Trabajador trabajadorAsignado = controlador.buscaTrabajadorAsignadoAPedido(pedidoElegido.getId());
    if (op == 1){
        %>
Aqui tienes el Pedido resumido <br>
        <%}else{
        if (op > 1) {
        %>
¿Es este el pedido deseado?<br>
<%
        }
    }
    if (op>1){
%>
<table border="2">
    <tr>
        <th colspan="5">
            <br>
            Pedido Elegido ID: <%=pedidoElegido.getId()%>
            <br><br>
        </th>
    </tr>
    <tr>
        <td>
            Estado
        </td>
        <td colspan="3"></td>
        <td>
            <%=pedidoElegido.getEstadoString()%>
        </td>
    </tr>
    <tr>
        <td>
            Fecha Pedido
        </td>
        <td colspan="3"></td>
        <td>
            <%=Utils.fechaAString(pedidoElegido.getFechaPedido())%>
        </td>
    </tr>
    <tr>
        <td>
            Fecha Estimada entrega
        </td>
        <td colspan="3"></td>
        <td>
            <%=Utils.fechaAString(pedidoElegido.getFechaEntregaEstimada())%>
        </td>
    </tr>
    <tr>
        <td>
            COMENTARIOS
        </td>
        <td colspan="3"></td>
        <td>
            <%=pedidoElegido.getComentario()%>
        </td>
    </tr>
    <tr>
        <th colspan="5">
           DATOS CLIENTE ID: <%=datosCliente.getIdCliente()%>
        </th>
    </tr>
    <tr>
        <td>
            Nombre del cliente
        </td>
        <td colspan="3"></td>
        <td>
            <%=datosCliente.getNombreCliente()%>
        </td>
    </tr>
    <tr>
        <td>
            Email del cliente
        </td>
        <td colspan="3"></td>
        <td>
            <%=datosCliente.getEmailCliente()%>
        </td>
    </tr>
    <tr>
        <td>
            Movil del cliente
        </td>
        <td colspan="3"></td>
        <td>
            <%=datosCliente.getMovilCliente()%>
        </td>
    </tr>
    <tr>
        <td>
            Direccion del cliente
        </td>
        <td colspan="3"></td>
        <td>
            <%=datosCliente.getDireccionCliente()%>
        </td>
    </tr>
    <tr>
        <td>
            Localidad
        </td>
        <td colspan="3"></td>
        <td>
            <%=datosCliente.getLocalidadCliente()%>(<%=datosCliente.getProvinciaCliente()%>)
        </td>
    </tr>
    <tr>
        <th colspan="5">
            Trabajador asignado ID <%=(trabajadorAsignado != null) ? trabajadorAsignado.getId() : "Trabajador no asignado"%>
        </th>
    </tr>
    <%
        if(trabajadorAsignado != null){
    %>
    <tr>
        <td>
            Nombre trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorAsignado.getNombre()%>
        </td>
    </tr>
    <tr>
        <td>
            Movil trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorAsignado.getMovil()%>
        </td>
    </tr>
    <tr>
        <td>
            Email trabajador
        </td>
        <td colspan="3"></td>
        <td>
            <%=trabajadorAsignado.getCorreo()%>
        </td>
    </tr>
    <%
        }
    %>
    <tr>
        <th colspan="5">
           PRODUCTOS
        </th>
    </tr>
    <%
        for(Producto p : pedidoElegido.getProductos()){

    %>
    <tr>
        <td>
            <%=p.getMarca()%>
        </td>
        <td>
            <%=p.getModelo()%>
        </td>
        <td>
            <%=pedidoElegido.getCantidadProductos().get(p.getId())%>
        </td>
        <td>
            <%=p.getPrecio()%>€ PVP
        </td>
        <td>
            <%=p.getPrecio()*pedidoElegido.getCantidadProductos().get(p.getId())%>€
        </td>
    </tr>
    <%
        }
    %>
    <tr>
        <td colspan="4">
            Precio Total Sin IVA
        </td>
        <td>
            <%=pedidoElegido.calculaTotalPedidoSinIVA()%>€
        </td>
    </tr>
    <tr>
        <td colspan="4">
            IVA a repercutir
        </td>
        <td>
            <%=pedidoElegido.calculaIVAPedido(DataIVA.IVA)%>€
        </td>
    </tr>
    <tr>
        <td colspan="4">
            IVA
        </td>
        <td>
            <%=pedidoElegido.calculaTotalPedidoConIVA(DataIVA.IVA)%>€
        </td>
    </tr>
</table>
<a href="seleccionPedidosAdmin.jsp?op=<%=parm%>&page=1">Volver a la selección de pedidos</a>
<br>
<%
    if((op == 2) && admin!=null) {
%>
<a href="menuModifPedidoAdmin.jsp?idPedido=<%=idPedido%>">Modificar este pedido</a>
<%
    }
%>
<%
    if((op == 3) && admin != null) {
%>
<a href="seleccionTrabajador.jsp?op=3&idPedido=<%=idPedido%>">Modificar este pedido</a>
<%
    }
%>
<%
    }
%>
</body>
</html>
