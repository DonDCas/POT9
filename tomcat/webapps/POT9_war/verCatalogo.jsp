<%@ page import="utils.UtilsWeb" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Practica Obligatoria Tema 9</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='css/main.css'>
</head>
<body>
<jsp:include page="includes/alerta.jsp" />
<%
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    String op = null;
    String opBrowser = "";
    int pages = 1;
    try{
        pages = Integer.parseInt(String.valueOf(request.getParameter("page")));
    } catch (NumberFormatException e) {
        pages = 1;
    }
    if (user == null && !controlador.modoInvitado()){
        UtilsWeb.volverIndexError(request, response);
    }
    if (user != null){
        op = request.getParameter("op");
        opBrowser = "&op="+op;
        request.getSession().setAttribute("op", opBrowser);
    }
    ArrayList <Producto> productosBuscados =  (ArrayList<Producto>) request.getSession().getAttribute("productosBuscados");
    if(productosBuscados == null){
        productosBuscados = controlador.getCatalogo();
        request.getSession().setAttribute("productosBuscados", productosBuscados);
    }
    int start = (pages - 1) * 5 +1;
    int end = Math.min(productosBuscados.size(), pages * 5)+1;
    int index = 0;
%>
<form method="post" action="<%=request.getContextPath()%>/MethodFiltrosCatalogo">
    <table align="center" border="2">
        <tr>
            <th colspan="6">
                Filtros de busqueda
            </th>
        </tr>
        <tr>
            <td rowspan="2">
                Descripcion
            </td>
            <td rowspan="2">
                Marcas
            </td>
            <td rowspan="2">
                Modelo
            </td>
            <td colspan="2">
                Rango de Precios
            </td>
            <td rowspan="2">
                Termino
            </td>
        </tr>
        <tr>
            <td>
                min
            </td>
            <td>
                max
            </td>
        </tr>
        <tr>
            <td>
                <input type="text" name="descripcion">
            </td>
            <td>
                <input type="text" name="marca">
            </td>
            <td>
                <input type="text" name="modelo">
            </td>
            <td>
                min:
                <input
                        type="range"
                        name="precioMin"
                        id="precioMin"
                        min="10"
                        max="3000"
                        step="10"
                        value="0"
                        oninput="document.getElementById('minOutput').value = this.value">
                <output id="minOutput">0</output>
            </td>

            <td>
                max:
                <input
                        type="range"
                        name="precioMax"
                        id="precioMax"
                        min="10"
                        max="3000"
                        step="10"
                        value="0"
                        oninput="document.getElementById('maxOutput').value = this.value">
                <output id="maxOutput">0</output>
            </td>
            <td>
                <input type="text" name="termino">
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Filtrar"></td>
            <td colspan="2"><input type="reset" value="vaciar filtros"></td>
            <td colspan="2">
                <button type="button" onclick="resetFormAndNotify()">Eliminar filtros</button>
                <script>
                    function resetFormAndNotify() {
                        document.querySelector("form").reset();
                        window.location.href = "ResetCatalogo.jsp";
                    }
                </script>
            </td>
        </tr>
    </table>
</form>
    <table border="3" align="center">
        <tr>
            <th colspan="4"></th>
        </tr>
<%
    for (Producto p : productosBuscados) {
        index++;
        String precioProducto = String.format("%.2f", p.getPrecio());
        if ((index <= pages*5) && index > (pages-1) * 5){
        if(p.getRelevancia()>=9) {
%>
        <tr>
            <td colspan="4">
                GRAN PROMOSION
            </td>
        </tr>
<%
        }
%>
        <tr>
            <td>
                Marca
            </td>
            <td>
                <%=p.getMarca()%>
            </td>
            <td>
                Modelo
            </td>
            <td>
                <a href="seleccionProducto.jsp?idProducto=<%=p.getId()+(opBrowser != null ? opBrowser : "")%>">
                    <%=p.getModelo()%>
                </a>
            </td>
        </tr>
        <tr>
            <td colspan="4"><%=p.getDescripcion()%></td>
        </tr>
        <tr>
            <td colspan="2">
                Precio
            </td>
            <td colspan="2">
                <%=precioProducto%>
            </td>
        </tr>
    <br>
<%
        }
    }
%>
        <tr>
            <td colspan="4">
                <% if (pages > 1) { %>
                <a href='verCatalogo.jsp?page=<%=(pages-1)+((op != null) ? opBrowser : "")%>'>Atras</a>
                <% } %>
                <%= "Productos " + start + " a " + (end - 1) + " de " + productosBuscados.size() %>
                <% if (end < productosBuscados.size()) { %>
                <a href='verCatalogo.jsp?page=<%=(pages+1)+((op != null) ? opBrowser : "")%>'>Siguiente</a>
                <% } %>
            </td>
        </tr>
        <%
            if (user == null ){
        %>
        <tr>
            <td colspan="4">
                <a href='index.jsp'>Volver de inicio</a>
            </td>
        </tr>
        <%
            }
        %>
        <%
            if (user != null && user instanceof Admin){
        %>
        <tr>
            <td colspan="4">
                <a href='Admin/menuAdmin.jsp'>Volver al menu del admin</a>
            </td>
        </tr>
        <%
            }
        %>
        <%
            if (user != null && user instanceof Trabajador){
        %>
        <tr>
            <td colspan="4">
                <a href='menuAdmin.jsp'>Volver al menu del trabajador</a>
            </td>
        </tr>
        <%
            }
        %>
        <%
            if (user != null && user instanceof Cliente){
        %>
        <tr>
            <td colspan="4">
                <a href='menuAdmin.jsp'>Volver al menu del Cliente</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</center>
</body>
</html>