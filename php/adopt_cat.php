<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$catid = $_POST['catid'];

$sql = "SELECT * FROM CAT WHERE CATID = '$catid'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $sqlupdate = "UPDATE CAT SET ADOPTER_EMAIL = '$email' WHERE CATID = '$catid'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'success';
    }else{
        echo 'failed';
    }  
} else {
    echo "failed";
}

?>