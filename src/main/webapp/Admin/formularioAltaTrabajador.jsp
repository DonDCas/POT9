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
<%
    Controlador controlador = new Controlador();
    Admin admin = (Admin) request.getSession().getAttribute("user");
%>
<script>
    const params = new URLSearchParams(window.location.search);
    if (params.get("error") === "1") {
        alert("Formulario incompleto");
    } else if (params.get("error") === "2") {
        alert("No se pudo volver a dar de alta a este trabajador");
    } else if (params.get("error") === "3"){
        alert("Esta contraseña no es valida.\n" +
            "- La clave debee de tener una longitud de 8 caracteres\n" +
            "- La clave debe de contener mayusculas\n" +
            "- La clave debe de contener minusculas\n" +
            "- La clave debe de contener numeros\n" +
            "- La clave debe de contener un caracter especial:" +
            " (-_!@/&.:,;·#$€%¬/()=?¿¡)");
    } else if (params.get("error") === "4"){
        alert("No se ha introducido un correo válido.");
    }  else if (params.get("error") === "5"){
        alert("Numero de telefono introducido de forma incorrecta.");
    }  else if (params.get("error") === "6"){
        alert("ID de telegram no se introdujo de forma incorrecta.");
    } else if (params.get("error") === "7"){
        alert("El correo pertenece a un trabajador ya dado de alta.");
    }

</script>
<table>
    <form method="post" action="MethodAltaTrabajador.jsp">
        <tr>
            <th colspan="3">Formulario para dar de alta trabajador</th>
        </tr>
        <tr>
            <td>Nombre del trabajador:</td>
            <td colspan="2"><input type="text" name="nombre"></td>
        </tr>
        <tr>
            <td>Correo:</td>
            <td colspan="2"><input type="email" name="correo"></td>
        </tr>
        <tr>
            <td>Contraseña:</td>
            <td colspan="2"><input type="password" name="pass"></td>
        </tr>
        <tr>
            <td>Movil:</td>
            <td colspan="2"><input type="number" name="movil"></td>
        </tr>
        <tr>
            <td>Id Telegram:</td>
            <td colspan="2"><input type="text" name="telegram"></td>
        </tr>
        <tr>
            <td><button name="volver" type="button" onclick="window.location.href='menuAdmin.jsp'">Volver al menu</button></td>
            <td><input type="submit" name="registrar" value="Registrar Trabajador"></td>
            <td><input type="reset" name="reset" value="Vaciar formulario"></td>
        </tr>
    </form>
</table>
</body>
</html>
