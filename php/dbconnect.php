<?php
$servername = "localhost";
$username   = "icebeary_yiying";
$password   = "19981229Yy#";
$dbname     = "icebeary_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
   die("Connection failed: " . $conn->connect_error);
}
?>