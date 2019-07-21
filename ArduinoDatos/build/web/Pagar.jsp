<%-- 
    Document   : Pagar
    Created on : 17/10/2018, 08:15:54 PM
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
        <link rel="icon" type="image/png" href="troll.png" />
        <title>♦ Pagar ♠</title>
    </head>
    <body background="pagar2.gif">
        <%
            //----CONEXION A LA BASE DE DATOS----
            Connection con;
            String url = "jdbc:mysql://localhost:3306/apartamento2";
            String Driver = "com.mysql.jdbc.Driver";
            String user = "root";
            String clave = "";
            Class.forName(Driver);
            con = DriverManager.getConnection(url, user, clave);
            Calendar cale = Calendar.getInstance();
            int año = cale.get(Calendar.YEAR);
            int mes = cale.get(Calendar.MONTH);
            int dia = cale.get(Calendar.DAY_OF_MONTH);
            String fechaA = "" + año + "-" + (mes + 1) + "-" + dia;
            //----LISTAR LOS DATOS DE LA TABLA PERO DE LA FILA SELECCIONADA----
            PreparedStatement ps;
            ResultSet rs;
            int id = Integer.parseInt(request.getParameter("id"));
            ps = con.prepareStatement("select * from usuario where Id=" + id);
            rs = ps.executeQuery();
            while (rs.next()) {
        %> 
        <div style="font-family: Caviar Dreams" class="container">
            <center>
                <font size=7 color="#0065FF" face="Hollywood Capital Hills">Pagar Arriendo</font>
                <hr>
                <form action="" method="post" class="form-control" style="width: 300px; height: 200px">
                    Codigo apartamento:
                    <input type="text" style="background-color:#C7C7C7;color:#4DB849;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:dotted;border-color:#4DB849; text-align:center;" readonly="" class="form-control" value="<%= rs.getInt("Id")%>"/>
                    Fecha de pago del arriendo:
                    <input type="date" style="background-color:#E2E2E2;color:#4DB849;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#1DD75F; text-align:center;" name="txtFechaUP" class="form-control" min="2000-01-01" max="<%=fechaA%>" required/>
                    <br>
                    <input type="submit" value="Pagar" class="btn btn-block btn-success"/>
                    <div align="center"><a href="index.jsp">Regresar</a></div>
                </form>
            </center>
            <%}%>
        </div>
    </body>
</html>
<%
    String fecha2;
    fecha2 = request.getParameter("txtFechaUP");
    if (fecha2 != null) {
        ps = con.prepareStatement("update usuario set Fecha2='" + fecha2 + "' where Id=" + id);
        ps.executeUpdate();
        response.sendRedirect("index.jsp");
    }
%>    