<?php
error_reporting(0);
include_once("dbconnect.php");
$catid = $_POST['catid'];

$sql = "SELECT * FROM COMMENT WHERE CATID = '$catid'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response["comments"] = array();
    while ($row = $result ->fetch_assoc()){
        $commentlist = array();
        $commentlist[name] = $row["NAME"];
        $commentlist[comment] = $row["COMMENTS"];
        array_push($response["comments"], $commentlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>