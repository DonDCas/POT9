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
    Pedido pedidoElegido = (Pedido) request.getSession().getAttribute("pedidoElegido");
    Pedido copiaPedido = (Pedido) request.getSession().getAttribute("copiaPedido");
    PedidoClienteDataClass datosCliente = (PedidoClienteDataClass) request.getSession().getAttribute("datosCliente");
    Trabajador trabajadorAsignado = (Trabajador) request.getSession().getAttribute("trabajadorAsignado");
%>
<% if (session.getAttribute("alerta1") != null) { %>
<script>alert('<%=session.getAttribute("alerta1")%>');</script>
<%
        session.removeAttribute("alerta1");
} %>
<% if (session.getAttribute("alerta2") != null) { %>
<script>alert('<%=session.getAttribute("alerta2")%>');</script>
<%
        session.removeAttribute("alerta2");
    } %>
<% if (session.getAttribute("alerta3") != null) { %>
<script>alert('<%=session.getAttribute("alerta3")%>');</script>
<%
        session.removeAttribute("alerta3");
    } %>
<table border="2">
    <tr>
        <th colspan="5">
            <br>
            Pedido Elegido ID: <%=copiaPedido.getId()%>
            <br><br>
        </th>
    </tr>
    <tr>
        <td>
            Estado
        </td>
        <td colspan="3"></td>
        <td>
            <%=copiaPedido.getEstadoString()%>
        </td>
    </tr>
    <tr>
        <td>
            Fecha Pedido
        </td>
        <td colspan="3"></td>
        <td>
            <%=Utils.fechaAString(copiaPedido.getFechaPedido())%>
        </td>
    </tr>
    <tr>
        <td>
            Fecha Estimada entrega
        </td>
        <td colspan="3"></td>
        <td>
            <%=Utils.fechaAString(copiaPedido.getFechaEntregaEstimada())%>
        </td>
    </tr>
    <tr>
        <td>
            COMENTARIOS
        </td>
        <td colspan="3"></td>
        <td>
            <%=copiaPedido.getComentario()%>
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
        for(Producto p : copiaPedido.getProductos()){

    %>
    <tr>
        <td>
            <%=p.getMarca()%>
        </td>
        <td>
            <%=p.getModelo()%>
        </td>
        <td>
            <%=copiaPedido.getCantidadProductos().get(p.getId())%>
        </td>
        <td>
            <%=p.getPrecio()%>€ PVP
        </td>
        <td>
            <%=p.getPrecio()*copiaPedido.getCantidadProductos().get(p.getId())%>€
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
            <%=copiaPedido.calculaTotalPedidoSinIVA()%>€
        </td>
    </tr>
    <tr>
        <td colspan="4">
            IVA a repercutir
        </td>
        <td>
            <%=copiaPedido.calculaIVAPedido(DataIVA.IVA)%>€
        </td>
    </tr>
    <tr>
        <td colspan="4">
            IVA
        </td>
        <td>
            <%=copiaPedido.calculaTotalPedidoConIVA(DataIVA.IVA)%>€
        </td>
    </tr>
</table>

<table>
    <form method="post" action="modifPedidoAdmin">
        <tr>
            <th colspan="4">Indica los cambios pertinentes</th>
        </tr>
        <tr>
            <td colspan="2">
                Estado: <br>
                <input type="radio" value="0" name="estado"> Creación <br>
                <input type="radio" value="1" name="estado"> En Preparación <br>
                <input type="radio" value="2" name="estado"> Enviado <br>
                <input type="radio" value="3" name="estado"> Cancelado <br>
            </td>
            <td>
                Fecha de entrega estimada: <br>
                <input type="date" name="fechaEstimada"> <br>
            </td>
            <td>
                Modificar comentario: <br>
                <input type="text" name="comentario"> <br>
            </td>
        </tr>
        <tr>
            <th colspan="2"><Input type="submit"></th>
    </form>
            <th><a href="guardarCambiosPedido"><button>Guardar cambios</button></a></th>
            <th><a href="seleccionPedidosAdmin.jsp?op=2&page=1"><button>Volver a la selección de Pedidos sin guardar</button></a></th>
        </tr>
</table>
</body>
</html>
