<?php
include_once("dbconnect.php");
$encoded_string = $_POST['encoded_string'];
$decoded_string = base64_decode($encoded_string);
$image = $_POST['image'];
$email = $_POST['email'];
$publisher = $_POST['publisher'];
$catname = $_POST['cat_name'];
$gender = $_POST['gender'];
$fee = $_POST['fee'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$description = $_POST['cat_detail'];

$path = '../hope4cat_image/'.$image;
//$is_written = file_put_contents($path, $decoded_string);

$sqluploadcat = "INSERT INTO CAT(EMAIL,FEE,DESCRIPTION,LATITUDE,LONGITUDE,PUBLISHER,GENDER,IMAGE,CATNAME) VALUES('$email','$fee','$description','$latitude','$longitude','$publisher','$gender','$image', '$catname')";

if ($conn->query($sqluploadcat) === TRUE){
    file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}
?>