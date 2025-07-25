<%@ page import="models.Controlador" %>
<%@ page import="models.Admin" %>
<%@ page import="models.Trabajador" %>
<%@ page import="models.Cliente" %>
<%@ page import="utils.Utils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    Controlador controlador = new Controlador();
    Object user = null;
    String correo = request.getParameter("correoUser");
    String pass = request.getParameter("pass");
    if (correo.isEmpty() || pass.isEmpty()){
        response.sendRedirect("login.html?error=1");
        return;
    }
    else{
        if (controlador.repairman(correo, pass))
            response.sendRedirect("Admin\\ImportarCopiaSeguridad.jsp?DontLogin=1");
        else{

            if (Utils.validaClave(pass) && Utils.validaCorreo(correo)){
                user = controlador.login(correo, pass);
            }else {
                if (!Utils.validaClave(pass)){
                    response.sendRedirect("login.html?error=3");
                    return;
                }
                if (!Utils.validaCorreo(correo)){
                    response.sendRedirect("login.html?error=4");
                    return;
                }
            }
            if (user == null){
                response.sendRedirect("login.html?error=2");
                return;
            }else{
                request.getSession().setAttribute("controlador", controlador);
                request.getSession().setAttribute("user", user);
                if(Controlador.registraInicioSesion(user)){
                    if (user instanceof Admin){
                        response.sendRedirect(".\\Admin\\menuAdmin.jsp");
                        return;
                    }
                    if (user instanceof Trabajador){
                        response.sendRedirect("menuTrabajador.jsp");
                        return;
                    }
                    if (user instanceof Cliente){
                        response.sendRedirect("menuCliente.jsp");
                        return;
                    }
                }
            }
        }
    }
%>
</body>
</html>