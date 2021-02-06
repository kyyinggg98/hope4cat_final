<?php
error_reporting(0);
include_once("dbconnect.php");
$catid  = $_POST['catid'];
$name = $_POST['name'];
$comments = $_POST['comment'];

$sql = "SELECT * FROM CAT WHERE CATID = '$catid'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $sqlupdate = "INSERT INTO COMMENT(CATID,NAME,COMMENTS) VALUES('$catid','$name','$comments')";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'success';
    }else{
        echo 'failed';
    }  
} else {
    echo "failed";
}

?>