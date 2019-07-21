<?php
$chipid = $_POST ['chipid'];
$temperatura = $_POST ['temperatura'];

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "arduino";

 // Creo la conexion a la base de datos
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifico que se hubiera conectado correctamente
if ($conn->connect_error) {
    die("Conexion fallida: " . $conn->connect_error);
}
echo "Conectado a la base de datos". PHP_EOL;
$sql = "INSERT INTO datos (chipId, fecha, temperatura) VALUES ('$chipid', CURRENT_TIMESTAMP, '$temperatura')";
if ($conn->query($sql) === TRUE) {
    echo "Datos correctamente insertados";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();

?>

 