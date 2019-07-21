<%-- 
    Document   : Delete
    Created on : 17/10/2018, 02:06:14 PM
    Author     : Mini
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar registro</title>
    </head>
    <body>
        <%
            //----CONEXION A LA BASE DE DATOS----
            Connection con;
            String url = "jdbc:mysql://localhost:3306/apartamento2";
            String Driver = "com.mysql.jdbc.Driver";
            String user = "root";
            String clave = "";
            Class.forName(Driver);
            con = DriverManager.getConnection(url, user, clave);
            //----LISTAR LOS DATOS DE LA TABLA PERO DE LA FILA SELECCIONADA----
            PreparedStatement ps;
            int id = Integer.parseInt(request.getParameter("id"));
            ps = con.prepareStatement("delete from usuario where Id=" + id);
            ps.executeUpdate();
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
