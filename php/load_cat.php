<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM CAT WHERE ADOPTER_EMAIL IS NULL AND EMAIL != '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["cats"] = array();
    while ($row = $result ->fetch_assoc()){
        $catlist = array();
        $catlist[catid] = $row["CATID"];
        $catlist[catname] = $row["CATNAME"];
        $catlist[fee] = $row["FEE"];
        $catlist[description] = $row["DESCRIPTION"];
        $catlist[latitude] = $row["LATITUDE"];
        $catlist[longitude] = $row["LONGITUDE"];
        $catlist[publisher] = $row["PUBLISHER"];
        $catlist[gender] = $row["GENDER"];
        $catlist[image] = $row["IMAGE"];
        $catlist[email] = $row["EMAIL"];
        array_push($response["cats"], $catlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>