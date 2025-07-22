<%@ page import="models.Controlador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    Controlador controlador = new Controlador();
    Object user = request.getSession().getAttribute("user");
    controlador.guardarNuevoInicioSesion(user);
    Controlador.registraCierreSesion(user);
    response.sendRedirect("index.jsp");
%>
</body>
</html>