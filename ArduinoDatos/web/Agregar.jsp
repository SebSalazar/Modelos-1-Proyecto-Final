<%-- 
    Document   : Agregar
    Created on : 16/10/2018, 07:26:35 PM
    Author     : Mini
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="rick1.png" />
        <title>☺ Insertar registro ☻</title>
    </head>
    <body background="fondo3.jpg">
        <%
            Calendar cale = Calendar.getInstance();
            int año = cale.get(Calendar.YEAR);
            int mes = cale.get(Calendar.MONTH);
            int dia = cale.get(Calendar.DAY_OF_MONTH);
            String fechaA = "" + año + "-" + (mes + 1) + "-" + dia;
        %>    
        <div style="color:#C2C2C2; font-family: Bangers" class="container">
            <h1> <font size=7 color="#337AB7" face="Bangers">Insertar nuevos datos</font> </h1>
            <hr>
            <form action="" method="post" class="form-control" style="width: 400px; height: 300px">
                ChipID ESP8266:
                <input type="number" value="1" style="background-color:#D3D3D3;color:#337AB7;font-size:12pt; font-family:Berlin Sans FB; border-width:medium;border-style:inset;border-color:#9F9F9F;" name="chipId" class="form-control" min="0" pattern="[0-9]{1,10}" title="Introduce solo numeros (0-9)" step="1" required/>
                Fecha:
                <input type="date" style="background-color:#D3D3D3;color:#337AB7;font-size:12pt; font-family:Berlin Sans FB; border-width:medium;border-style:inset;border-color:#9F9F9F;" name="fecha" class="form-control" max="<%=fechaA%>" required/>
                Temperatura:
                <input type="number" value="1" style="background-color:#D3D3D3;color:#337AB7;font-size:12pt; font-family:Berlin Sans FB; border-width:medium;border-style:inset;border-color:#9F9F9F;" name="temperatura" class="form-control" min="0" pattern="[0-9]{1,10}" title="Introduce solo numeros (0-9)" step="10" required/>
                <br>
                <input type="submit" value="Guardar" class="btn btn-primary btn-lg"/>
                <input type="reset" value="Limpiar" class="btn btn-warning"/></a>
                <a href="index.jsp">Regresar</a>
            </form>
        </div>
    </body>
</html>
<%
    //----CONEXION A LA BASE DE DATOS----
    Connection con;
    String url = "jdbc:mysql://localhost:3306/arduino";
    String Driver = "com.mysql.jdbc.Driver";
    String user = "root";
    String clave = "";
    Class.forName(Driver);
    con = DriverManager.getConnection(url, user, clave);
    PreparedStatement ps;
    String  val, fecha1, fecha2;
    val = request.getParameter("chipId");
    fecha1 = request.getParameter("fecha");
    fecha2 = request.getParameter("temperatura");
    if (val != null && fecha1 != null && fecha2 != null) {
        ps = con.prepareStatement("insert into datos(chipId,fecha,temperatura)values('" + val + "','" + fecha1 + "','" + fecha2  + "')");
        ps.executeUpdate();
        response.sendRedirect("index.jsp");
    }
%>            
