<%-- 
    Document   : Fechas
    Created on : 18/10/2018, 12:59:15 AM
    Author     : Mini
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="horror.png" />
        <title>▼ ▲Atrasados▲ ▼</title>
        <%
            String fechaMenosDeUnMes;
            String fechaMasDeUnMes;
        %>
    </head>
    <body background="fecha.gif">
        <%
            //----CONEXION A LA BASE DE DATOS----
            Connection con;
            String url = "jdbc:mysql://localhost:3306/apartamento2";
            String Driver = "com.mysql.jdbc.Driver";
            String user = "root";
            String clave = "";
            Class.forName(Driver);
            con = DriverManager.getConnection(url, user, clave);
            //----LISTAR LOS DATOS DE LA TABLA----
            Calendar cale = Calendar.getInstance();
            int año = cale.get(Calendar.YEAR);
            int mes = cale.get(Calendar.MONTH);
            int dia = cale.get(Calendar.DAY_OF_MONTH);
            String fechaA = "" + año + "-" + (mes + 1) + "-" + dia;
            if (mes < 10) {
                fechaMenosDeUnMes = "" + año + "-0" + mes + "-" + dia;
                fechaMasDeUnMes = "" + año + "-0" + mes + "-" + (dia - 1);
            } else {
                fechaMenosDeUnMes = "" + año + "-" + mes + "-" + dia;
                fechaMasDeUnMes = "" + año + "-" + mes + "-" + (dia - 1);
            }
            String fechaold = "1990-01-01";
            PreparedStatement ps;
            ResultSet rs;
            ps = con.prepareStatement("select * from usuario where Fecha2 between '" + fechaMenosDeUnMes + "' and '" + fechaA + "'");
            rs = ps.executeQuery();
        %>
        <div style="font-family: Helsinki" class='container'>  
            <center> <h1> <font size=7 color="#1B164C" face="Bangers">Inquilinos atrasados un Mes o menos</font> </h1> </center>
            <hr>
            <table  style="font-family: Helsinki" class='table table-striped table-bordered' background="tabla.gif">
                <tr style="color:#1B164C;">
                    <th class='text-center'>CODIGO APT</th> 
                    <th class='text-center'>VALOR ARRIENDO</th> 
                    <th class='text-center'>FECHA DE PAGO MENSUAL</th> 
                    <th class='text-center'>FECHA DE ULTIMO PAGO</th> 
                    <th class='text-center'>DIRECCION</th> 
                    <th class='text-center'>ARRENDATARIO</th>
                    <th class='text-center'>ARRENDADOR</th> 
                    <th class='text-center'>VALOR JUDICIAL</th>
                </tr>
                <%
                    while (rs.next()) {
                %>    
                <tr>
                    <td class='text-center'><%= rs.getInt("Id")%> </td>
                    <td class='text-center'><%= rs.getString("CostoA")%> </td>
                    <td class='text-center'><%= rs.getString("Fecha1")%> </td>
                    <td class='text-center'><%= rs.getString("Fecha2")%> </td>
                    <td class='text-center'><%= rs.getString("Direccion")%> </td>
                    <td class='text-center'><%= rs.getString("Cliente")%> </td>
                    <td class='text-center'><%= rs.getString("Servidor")%> </td>
                    <td class='text-center'><%= rs.getString("CostoE")%> </td>                    
                </tr>
                <% }%>  
            </table>
            <a href="index.jsp"><input type="submit" value="Regresar" class="btn btn-primary"/></a>
        </div>
        <!-- -->
        <%
            if (rs.next() != true) {
                ps = con.prepareStatement("select * from usuario where Fecha2 between '" + fechaold + "' and '" + fechaMasDeUnMes + "'");
                rs = ps.executeQuery();
        %> 
        <div style="font-family: Helsinki" class='container'>  
            <center> <h1> <font size=7 color="#BD256A" face="Bangers">Inquilinos atrasados mas de un Mes</font> </h1> </center>
            <hr>
            <table style="font-family: Comic Sans MS" class='table table-striped table-bordered' background="tabla.gif">
                <tr style="color:#BD256A;">
                    <th class='text-center'>CODIGO APT</th> 
                    <th class='text-center'>VALOR ARRIENDO</th> 
                    <th class='text-center'>FECHA DE PAGO MENSUAL</th> 
                    <th class='text-center'>FECHA DE ULTIMO PAGO</th> 
                    <th class='text-center'>DIRECCION</th> 
                    <th class='text-center'>ARRENDATARIO</th>
                    <th class='text-center'>ARRENDADOR</th> 
                    <th class='text-center'>VALOR JUDICIAL</th>
                </tr>
                <%
                    while (rs.next()) {
                %>    
                <tr>
                    <td class='text-center'><%= rs.getInt("Id")%> </td>
                    <td class='text-center'><%= rs.getString("CostoA")%> </td>
                    <td class='text-center'><%= rs.getString("Fecha1")%> </td>
                    <td class='text-center'><%= rs.getString("Fecha2")%> </td>
                    <td class='text-center'><%= rs.getString("Direccion")%> </td>
                    <td class='text-center'><%= rs.getString("Cliente")%> </td>
                    <td class='text-center'><%= rs.getString("Servidor")%> </td>
                    <td class='text-center'><%= rs.getString("CostoE")%> </td>                    
                </tr>
                <% }%>  
            </table>
            <a href="index.jsp"><input type="submit" value="Regresar" class="btn btn-danger"/></a>
        </div> 
        <% }%>  
    </body>
</html>
