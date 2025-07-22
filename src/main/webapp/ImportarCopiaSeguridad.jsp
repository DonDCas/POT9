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
    Object user = request.getSession().getAttribute("user");
%>
<form method="post" action="importarBackup" enctype="multipart/form-data">
    <input type="file" name="RutaBackUpImport"><br>
    <button>Importar BackUp</button>
</form>
</body>
</html>
