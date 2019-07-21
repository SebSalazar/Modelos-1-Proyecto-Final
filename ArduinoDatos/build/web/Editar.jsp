<%-- 
    Document   : Editar
    Created on : 17/10/2018, 11:36:03 AM
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
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="image/png" href="pepino.png" />
        <title>♣ Editar registro ○</title>
    </head>
    <body background="fondoEdit.jpg">
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
        <div style="font-family: Helsinki" class="container">
            <center>
                <h1> <font size=7 color="#D9534F" face="Russian">Editar Apartamento</font> </h1>
                <hr>
                <form action="" method="post" class="form-control" style="width: 400px; height: 514px">
                    Codigo apartamento:
                    <input type="text" style="background-color:#C7C7C7;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:dotted;border-color:#F27860; text-align:center;" readonly="" class="form-control" value="<%= rs.getInt("Id")%>"/>
                    Valor del arriendo:
                    <input type="number" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtValorA" class="form-control"value="<%= rs.getString("CostoA")%>" min="0" pattern="[0-9]{1,10}" title="Introduce solo numeros (0-9)" step="100" required/>
                    Fecha de pago mensual:
                    <input type="date" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtFechaP" class="form-control" value="<%= rs.getString("Fecha1")%>" max="<%=fechaA%>" required/>
                    Fecha de ultimo pago:
                    <input type="date" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtFechaUP" class="form-control" value="<%= rs.getString("Fecha2")%>" max="<%=fechaA%>" required/>
                    Direccion:
                    <input type="text" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtDireccion" class="form-control" value="<%= rs.getString("Direccion")%>" required/>
                    Nombre del Arrendatario:
                    <input type="text" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtArrendatario" class="form-control" value="<%= rs.getString("Cliente")%>" pattern="[a-zA-ZÁÉÍÓÚñáéíóú ]+{2,40}" title="Introduce nombres validos (a-z)" required/>
                    Nombre del Arrendador:
                    <input type="text" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtArrendador" class="form-control" value="<%= rs.getString("Servidor")%>" pattern="[a-zA-ZÁÉÍÓÚñáéíóú ]+{2,40}" title="Introduce nombres validos (a-z)" required/>
                    Valor extra-judicial:
                    <input type="number" style="background-color:#E2E2E2;color:#D9534F;font-size:12pt; font-family:Comic Sans MS; border-width:medium;border-style:inset;border-color:#D9534F;" name="txtValorJ" class="form-control" value="<%= rs.getString("CostoE")%>" min="0" pattern="[0-9]{1,10}" title="Introduce solo numeros (0-9)" step="100" required/>
                    <br>
                    <input type="submit" value="Guardar" class="btn btn-block btn-danger"/>
                    <div align="center"><a href="index.jsp">Regresar</a></div>
                </form>
            </center>
            <%}%>
        </div>
    </body>
</html>
<%
    String val, fecha1, fecha2, dir, inqui, arren, valj;
    val = request.getParameter("txtValorA");
    fecha1 = request.getParameter("txtFechaP");
    fecha2 = request.getParameter("txtFechaUP");
    dir = request.getParameter("txtDireccion");
    inqui = request.getParameter("txtArrendatario");
    arren = request.getParameter("txtArrendador");
    valj = request.getParameter("txtValorJ");
    if (val != null && fecha1 != null && fecha2 != null && inqui != null && arren != null && valj != null && dir != null) {
        ps = con.prepareStatement("update usuario set CostoA='" + val + "',Fecha1='" + fecha1 + "',Fecha2='" + fecha2 + "',Direccion='" + dir + "',Cliente='" + inqui + "',Servidor='" + arren + "',CostoE='" + valj + "' where Id=" + id);
        ps.executeUpdate();
        response.sendRedirect("index.jsp");
    }
%>    