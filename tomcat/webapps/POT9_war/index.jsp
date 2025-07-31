<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Practica Obligatoria Tema 9</title>
</head>
<body>
<%
    String alerta = (String) request.getSession().getAttribute("alerta");
    if (alerta != null) {
%>
<script>
    alert("<%= alerta %>");
    window.location.href = "<%= request.getContextPath() %>/inicio";
</script>
<%
        request.getSession().removeAttribute("alerta");
    } else {
        response.sendRedirect("inicio");
    }
    request.getSession().invalidate();
%>
</body>
</html>