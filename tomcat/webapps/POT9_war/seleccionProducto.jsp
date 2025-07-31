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
<%
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    String opBrowser = null;
    if (request.getSession().getAttribute("op") != null){
        opBrowser = request.getSession().getAttribute("op").toString();
    }
    String op = null;
    if (opBrowser != null){
        op = opBrowser.substring(opBrowser.indexOf("="));
    }
    if (request.getParameter("idProducto") == null){
        UtilsWeb.volverIndexError(request, response);
        return;
    }
    Producto producto = null;
    try{
        producto = controlador.buscaProductoById(Integer.parseInt(request.getParameter("idProducto")));
        Producto productoElegido = new Producto(producto);
        request.getSession().setAttribute("productoElegido", productoElegido);
    } catch (NumberFormatException e) {
        UtilsWeb.volverIndexError(request, response);
    }
    String precioProducto = String.format("%.2f", producto.getPrecio());
    if (user !=  null && op != null) {
        if(user instanceof Cliente){
%>
    ¿Deseas añadir este producto al carrito?
<%
        }else {
%>
    ¿Deseas modificar este producto?
<%
        }
    }else {
%>
    Aqui tienes el producto completo
<%
    }
%>
<table border="3" align="center">
    <tr>
        <th colspan="4">IP del Producto : <%=producto.getId()%></th>
    </tr>
    <tr>
        <td>
            Marca
        </td>
        <td>
            <%=producto.getMarca()%>
        </td>
        <td>
            Modelo
        </td>
        <td>
                <%=producto.getModelo()%>
        </td>
    </tr>
    <tr>
        <td colspan="4"><%=producto.getDescripcion()%></td>
    </tr>
    <tr>
        <td <%=(user!=null && !(user instanceof Cliente) ? "" : "colspan='2'")%>>
            Precio
        </td>
        <td <%=(user!=null && !(user instanceof Cliente) ? "" : "colspan='2'")%>>
            <%=precioProducto%>
        </td>
        <%
            if ((user!=null) && !(user instanceof Cliente)){
        %>
        <td>
            Relevancia
        </td>
        <td>
            <%=producto.getRelevancia()%>
        </td>
        <%
            }
        %>
    </tr>
    <tr>
        <td colspan="4">
            <a href='verCatalogo.jsp?page=<%=1+((op != null) ? opBrowser : "")%>'><button>Volver a ver el catalogo</button></a>
<%
                if (user!=null) {
                  if (user instanceof Cliente){

%>
                <form method="post">
                    <input type="number" value="1" name="Cantidad">
                    <input type="submit">
                </form>
<%
                }if(op!=null){
%>
            <a href='editarProducto.jsp'><button>Editar este producto</button></a>
<%
                    }
                }
%>
        </td>
    </tr>
    <%
        if (user == null ){
    %>
    <tr>
        <td colspan="4">
            <a href='index.jsp'>
                <button>
                    Volver de inicio
                </button>
            </a>
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
            <a href='Admin/menuAdmin.jsp'>
                <button>
                    Volver al menu del admin
                </button>
            </a>
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