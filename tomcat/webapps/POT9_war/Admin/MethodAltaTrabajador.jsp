<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %>
<%@ page import="models.Trabajador" %>
<%@ page import="utils.Utils" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Pedido" %>
<%@ page import="utils.UtilsPass" %><%--
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
    Admin admin = (Admin) request.getSession().getAttribute("user");
    if (admin == null){
        request.getSession().setAttribute("alerta", "ERROR GARRAFAL! Volviendo al Inicio");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
        return;
    }
    String correo = request.getParameter("correo");
    if (!Utils.validaCorreo(correo)){
        response.sendRedirect("formularioAltaTrabajador.jsp?error=4");
        return;
    }
    Trabajador trabajadorExistente = controlador.buscaTrabajadorByEmail(correo);
    if (trabajadorExistente != null) {
        if (trabajadorExistente.isBaja()){
            request.getSession().setAttribute("trabajadorExistente", trabajadorExistente);
            ArrayList <Pedido> pedidosTrabajador = controlador.recuperaPedidosAsignadosTrabajador(trabajadorExistente);

%>
    <table>
        <tr>
            <th colspan="2">Trabajador ya registrado</th>
        </tr>
        <tr>
            <td>
                ID del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getId()%>
            </td>
        </tr>
        <tr>
            <td>
                Nombre del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getNombre()%>
            </td>
        </tr>

        <tr>
            <td>
                Correo del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getNombre()%>
            </td>
        </tr>

        <tr>
            <td>
                Movil del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getMovil()%>
            </td>
        </tr>
        <tr>
            <td>
                ID de Telegram del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getIdTelegram()%>
            </td>
        </tr>
        <tr>
            <td>
                Numeros de pedidos completados del trabajador:
            </td>
            <td>
                <%=trabajadorExistente.getPedidosCompletados(pedidosTrabajador).size()%>
            </td>
        </tr>
        <form method="post" action="MethodAltaTrabajador">
            <tr>
                <td>
                    Contraseña del trabajador:
                </td>
                <td>
                    <input type="password" required name="pass">
                </td>
            </tr>
            <tr>
            <input type="submit" value="Volver a Dar de Alta Usuario">
        </form>
            <a href="formularioAltaTrabajador.jsp">
                <button> Volver al formulario de alta</button>
            </a>
            </tr>
    </table>
        <%
        }else{
            response.sendRedirect("formularioAltaTrabajador.jsp?error=7");
            return;
        }
    }else{
        String pass = request.getParameter("pass");
        String nombre = request.getParameter("nombre");
        int numMovil = -1;
        int idTelegram = -1;
        String num = String.valueOf(request.getParameter("movil"));
        try{
            numMovil = Integer.parseInt(num);
        } catch (NumberFormatException e) {
            response.sendRedirect("formularioAltaTrabajador.jsp?error=5");
            return;
        }
        try{
            idTelegram = Integer.parseInt(String.valueOf(request.getParameter("telegram")));
        } catch (NumberFormatException e) {
            response.sendRedirect("formularioAltaTrabajador.jsp?error=6");
            return;
        }
        if (!Utils.validaTelefono(numMovil)){
            response.sendRedirect("formularioAltaTrabajador.jsp?error=5");
            return;
        }
        if (!Utils.validaClave(pass)){
            response.sendRedirect("formularioAltaTrabajador.jsp?error=3");
            return;
        }

            if (!controlador.nuevoTrabajador(correo, pass, nombre, numMovil, idTelegram)){
                response.sendRedirect("formularioAltaTrabajador.jsp?error=1");
                return;
            }else {
                request.getSession().setAttribute("alerta", "Trabajador nuevo registrado");
                response.sendRedirect("menuAdmin.jsp");
            }

    }
%>
</body>
</html>
