<%@ page import="java.util.ArrayList" %>
<%@ page import="models.*" %><%--
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js" ></script>

</head>
<body>
<script>
    window.addEventListener('DOMContentLoaded', function(){
        fetch('<%= request.getContextPath() %>/Admin/grafico')
            .then(response => {
                console.log("¿Es JSON?", response);
                return response.json();
            })
            .then(data => {
                console.log('Datos recibidos:', data);
                const ctx = document.getElementById('graficoEstados').getContext('2d');
                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: ['Creado', 'En proceso', 'Enviado', 'Cancelado'],
                        datasets: [{
                            data: data,
                            backgroundColor: ['green', 'red', 'blue', 'gray']
                        }]
                    }
                });
            });
    })
</script>
<%
    Controlador controlador = new Controlador();
    Admin user = (Admin) request.getSession().getAttribute("user");
    if (user == null) {
        request.getSession().setAttribute("alerta", "ERROR GARRAFAL VOLVIENDO AL INICIO.");
        request.getRequestDispatcher("../index.jsp").forward(request, response);
        return;
    }
    ArrayList<Cliente> clientes = controlador.getClientes();
    ArrayList<Trabajador> trabajadores = controlador.getTrabajadoresDeAlta();
    ArrayList<Pedido> pedidos = controlador.getTodosPedidos();
%>
<table border="3">
    <tr>
        <th colspan="2">ESTADISTICAS DE LA APP</th>
    </tr>
    <tr>
        <td>Numero de Clientes</td>
        <td><%=clientes.size()%></td>
    </tr>
    <tr>
        <td>Numero de Trabajadores</td>
        <td><%=trabajadores.size()%></td>
    </tr>
    <tr>
        <td>Numero de Pedidos totales</td>
        <td><%=controlador.numPedidosTotales()%></td>
    </tr>
    <tr>
        <td>Pedidos en estado "Creado"</td>
        <td><%=controlador.numPedidosSoloCreados(pedidos)%></td>
    </tr>
    <tr>
        <td>Pedidos en estado "En Preparacion"</td>
        <td><%=controlador.numPedidosEnPreparacion(pedidos)%></td>
    </tr>
    <tr>
        <td>Pedidos en estado "Enviado"</td>
        <td><%=controlador.numPedidosEnviados(pedidos)%></td>
    </tr>
    <tr>
        <td>Pedidos en estado "Cancelado"</td>
        <td><%=controlador.numPedidosCancelados(pedidos)%></td>
    </tr>
    <tr>
        <td>Pedidos sin trabajador asignado</td>
        <td><%=controlador.pedidosSinTrabajador().size()%></td>
    </tr>
    <tr>
        <td colspan="2">
            <canvas id="graficoEstados" width="400" height="400"></canvas>
        </td>
    </tr>
</table>
<button type="button" onclick="window.location.href='menuAdmin.jsp'">Volver</button>
</body>
</html>
