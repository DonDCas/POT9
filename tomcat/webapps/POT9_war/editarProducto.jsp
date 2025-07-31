<%@ page import="models.Controlador" %>
<%@ page import="utils.UtilsWeb" %>
<%@ page import="models.Producto" %><%--
  Created by IntelliJ IDEA.
  User: usuario
  Date: 31/07/2025
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Practica Obligatoria Tema 9</title>
</head>
<body>
    <jsp:include page="includes/alerta.jsp" />


<%
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    String opBrowser = null;
    Producto productoElegido = (Producto) request.getSession().getAttribute("productoElegido");
    if (request.getSession().getAttribute("op") != null){
        opBrowser = request.getSession().getAttribute("op").toString();
    }
    UtilsWeb.usuarioNull(user, request, response, "index.jsp");
    if (opBrowser == null){
        UtilsWeb.volverIndexError(request, response);
        return;
    }
    if (productoElegido == null){
        UtilsWeb.volverMenuError(user, request, response, "ERROR, Producto no existente, volviendo al menu");
        return;
    }
    String precioProducto = String.format("%.2f", productoElegido.getPrecio());
%>
Este es el producto en su estado actual:
<form method="post" action="MethodModifProducto">
    <table>
        <tr>
            <th colspan="4">Rellena los datos que quieres modificar</th>
        </tr>
        <tr>
            <td>
                Marca
            </td>
            <td>
                <input type="text" name="marca" value="<%=productoElegido.getMarca()%>">
            </td>
            <td>
                Modelo
            </td>
            <td>
                <input type="text" name="modelo" value="<%=productoElegido.getModelo()%>">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                Descripcion
            </td>
            <td colspan="2">
                <textarea name="descripcion" rows="10" cols="20">
                    <%=productoElegido.getDescripcion()%>
                </textarea>
            </td>
        </tr>
        <tr>
            <td>
                Precio
            </td>
            <td>
                <input type="text" name="precio" value="<%=precioProducto%>">
            </td>
        </tr>
        <tr>
            <td>
                Relevancia
            </td>
            <td>
                <input type="number" name="relevancia" value="<%=productoElegido.getRelevancia()%>">
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="Realizar Cambios">
            </td>
            <td>
                <input type="reset" value="Borrar Cambios actuales">
            </td>
            <td>
                <button type="submit" value="descartar" name="action">Descartar Cambios</button>
            </td>
            <td>
                <button type="submit" value="guardar" name="action">Guardar Cambios</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
