<%-- 
    Document   : index
    Created on : 16/10/2018, 05:32:55 PM
    Author     : Mini Salazar
--%>

<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="iconr.png" />
        <title>Inicio</title>
    </head>
    <body background="fondo2.png">
        <%
            //----CONEXION A LA BASE DE DATOS----
            Connection con;
            String url = "jdbc:mysql://localhost:3306/arduino";
            String Driver = "com.mysql.jdbc.Driver";
            String user = "root";
            String clave = "";
            Class.forName(Driver);
            con = DriverManager.getConnection(url, user, clave);
            //----LISTAR LOS DATOS DE LA TABLA----
            PreparedStatement ps;
            ResultSet rs;
            ps = con.prepareStatement("select * from datos");
            rs = ps.executeQuery();
            //----SE CREA LA TABLA---
        %> 
        <div style="font-family: Berlin Sans FB" class='container'>
            <center> <h1> <font size=7 color="#A94442" face="Berlin Sans FB">Proyecto Final Modelos 1 (Envio de datos ESP8266)</font> </h1> </center>
            <hr style="border-style:dashed ;border-color:#9F9F9F" >
            <a class='btn btn-success btn-lg' href="Agregar.jsp">Insertar datos</a>
            <div class="container buscar">
                <form class="form">
                    <input style="background: #f0ffff; border-style: dashed" class="form-control" type="text" name="txtbuscar">
                    <input style="border-style: groove" class="btn btn-info" type="submit" value="Buscar">
                </form>
                <%
                    String nombuscar = request.getParameter("txtbuscar");
                    if (nombuscar != null) {
                        rs = ps.executeQuery("select * from datos where id LIKE" + "'%" + nombuscar + "%'");
                        //rs= ps.executeQuery("select * from usuario where Id LIKE"+"'%"+nombuscar+"%'");
                    } else {
                        System.err.print("Error");
                    }
                %>    
            </div>
            <br>
            <table style="border-width:medium;border-style:dotted; border-color:#C2C2C2; font-family: Berlin Sans FB" class='table table-bordered table-hover' background="tabla.gif">
                <tr>
                    <th class='text-center text-primary'>ID</th> 
                    <th class='text-center text-danger'>CHIP ID ESP8266</th> 
                    <th class='text-center text-primary'>FECHA</th> 
                    <th class='text-center text-danger'>TEMPERATURA</th>
                    <th class='text-center text-danger'>MODIFICAR</th>
                    <th class='text-center text-success'>MAS INFO</th>   
                </tr>
                <%
                    while (rs.next()) {
                %>    
                <tr>
                    <td class='text-center'><%= rs.getInt("id")%> </td>
                    <td class='text-center'><%= rs.getString("chipId")%> </td>
                    <td class='text-center'><%= rs.getString("fecha")%> </td>
                    <td class='text-center'><%= rs.getString("temperatura")%> </td>
                    <td class='text-center'>
                        <a href="Eliminar.jsp?id=<%= rs.getInt("id")%>" class='btn btn-danger btn-sm'>Eliminar</a>
                    </td>
                    <td><a href="Pagar.jsp?id=<%= rs.getInt("Id")%>" class='btn btn-success btn-block'>Consultar</a></td>
                </tr>
                <% }%>        
            </table>
        </div>
        <div style="font-family: Berlin Sans FB" class=" container footer">
            <center> <p>Hecho por Sebastian Salazar, Nicolas Baena y Jheisson Fortich (c) 2019</p> </center>
        </div>
    </body>
</html>
