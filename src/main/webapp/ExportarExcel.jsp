<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Practica Obligatoria Tema 9</title>
</head>
<body>
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
    <script>
            const params = new URLSearchParams(window.location.search);
            if (params.get("Valid") === "1") {
             alert ("Envio Realizado")
            }
    </script>
    <%
        Controlador controlador = new Controlador();
    %>
    <table>
        <tr>
            <th colspan="3"><center>Lista de pedidos</center></th>
        </tr>
        <tr>
            <td colspan="3">Elige de que pedidos quieres recibir el informe en formato EXCEL</td>
        </tr>
        <tr>
            <td>
                Listado de pedidos
            </td>
            <td>
                Cantidad de pedidos
            </td>
        </tr>
        <tr>
            <td>
                Listado de todos los pedidos realizados
            </td>
            <td>
                <%=controlador.getTodosPedidos().size()%>
            </td>
            <td>
                <a href="MethodEnviarExcel.jsp?Op=1"><button>Enviar Informe</button></a>
            </td>
        </tr>
        <tr>
            <td>
                Listado de todos los pedidos sin Asignación
            </td>
            <td>
                <%=controlador.pedidosSinTrabajador().size()%>
            </td>
            <td>
                <a href="MethodEnviarExcel.jsp?Op=2"><button>Enviar Informe</button></a>
            </td>
        </tr>
        <tr>
            <td>
                Listado de todos los pedidos completados
            </td>
            <td>
                <%=controlador.getPedidosCompletados().size()%>
            </td>
            <td>
                <a href="MethodEnviarExcel.jsp?Op=3"><button>Enviar Informe</button></a>
            </td>
        </tr>
        <tr>
            <td>
                Listado de todos los pedidos Sin Completar
            </td>
            <td>
                <%=controlador.getPedidosSinCompletar().size()  %>
            </td>
            <td>
                <a href="MethodEnviarExcel.jsp?Op=4"><button>Enviar Informe</button></a>
            </td>
        </tr>
    </table>
    <a href="MenuAdmin.jsp"><button>Volver al menu</button></a>
</body>
</html>