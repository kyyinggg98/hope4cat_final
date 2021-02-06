<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$name = $_POST['name'];
$phone = $_POST['phone'];

$sql = "SELECT * FROM USER WHERE EMAIL = '$email' AND OTP = '0'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $sqlupdate = "UPDATE USER SET NAME = '$name', PHONE = '$phone' WHERE EMAIL = '$email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'success';
    }else{
        echo 'failed';
    }   
}else{
    echo "failed";
}
?>