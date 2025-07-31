<%@ page import="models.Controlador" %><%--
  Created by IntelliJ IDEA.
  User: usuario
  Date: 30/07/2025
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  Controlador controlador = new Controlador();
  request.getSession().setAttribute("productosBuscados", controlador.getCatalogo());
  String opBrowser = (request.getSession().getAttribute("opBrowser") != null ? request.getSession().getAttribute("opBrowser").toString() : "");
  response.sendRedirect("verCatalogo.jsp?page=1"+((!opBrowser.isEmpty()) ? opBrowser : ""));
%>
</body>
</html>
