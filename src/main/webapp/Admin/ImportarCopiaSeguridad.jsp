<%@ page import="models.Admin" %>
<%@ page import="models.Controlador" %>
<%@ page import="utils.Utils" %>
<%@ page import="org.apache.logging.log4j.core.util.Integers" %><%--
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
    String opParam = request.getParameter("DontLogin");
    if (opParam != null && Utils.esDigito(opParam)) {
        int dontLogin = Integers.parseInt(opParam);
        if (dontLogin == 1){
            %>
                <form method="post" action="importarBackup" enctype="multipart/form-data">
                    <input type="file" name="RutaBackUpImport"><br>
                    <input type="hidden" name="dontLogin" value="1">
                    <button>Importar BackUp</button>
                </form>
            <%
        }
    }else{

%>
<form method="post" action="importarBackup" enctype="multipart/form-data">
    <input type="file" name="RutaBackUpImport"><br>
    <button>Importar BackUp</button>
</form>
<%
    }
%>
</body>
</html>
