<%
    String alerta = (String) request.getSession().getAttribute("alerta");
    if (alerta != null) {
        request.getSession().removeAttribute("alerta");
%>
<script>
    alert('<%= alerta.replace("'", "\\\\'") %>');
</script>
<%
    }
%>