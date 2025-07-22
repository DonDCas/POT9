<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %>
<%@ page import="utils.Utils" %><%--
  Created by IntelliJ IDEA.
  User: dondc
  Date: 22/07/2025
  Time: 8:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Practica Obligatoria Tema 9</title>
</head>xº
<body>
<%
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    Admin admin = (Admin) user;
    int op = 0;
%>
<script>
    <%
    String opParam = request.getParameter("Op");
    if (opParam != null && Utils.esDigito(opParam)) {
        op = Integer.parseInt(request.getParameter("Op"));
    }
        if (op < 1 || op > 4){

    %>
    alert("Opción no disponible.");
    <%
        }else{
            switch (op){
                case 1 -> controlador.exportarAExcelPedidos(controlador.getTodosPedidos(), "TodosLosPedidos", admin.getCorreo());
                case 2 -> controlador.exportarAExcelPedidos(controlador.pedidosSinTrabajador(), "PedidosSinAsignar", admin.getCorreo());
                case 3 -> controlador.exportarAExcelPedidos(controlador.getPedidosCompletados(), "Pedidos_Completados", admin.getCorreo());
                case 4 -> controlador.exportarAExcelPedidos(controlador.getPedidosSinCompletar(), "Pedidos_Sin_Completar", admin.getCorreo());
            }
        }
    %>
    window.location.href="ExportarExcel.jsp?Valid=1";
</script>
</body>
</html>
