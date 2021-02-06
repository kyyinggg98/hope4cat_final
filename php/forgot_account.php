<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqlforgotaccount = "SELECT * FROM USER WHERE EMAIL = '$email'";
$result = $conn->query($sqlforgotaccount);

if ($result->num_rows > 0) {
    sendEmail($password,$email);
    echo "success";
}else{
    echo "failed";
}

function sendEmail($password,$email){
    $from = "noreply@hope4cat.com";
    $to = $email;
    $subject = "From HOPE4CAT. Verify your new password";
    $message = "Use the following link to confirm changing your account password :"."\n http://http://icebeary.com/hope4cat/verify_account.php?email=".$email."&key=".$password;
    $headers = "From:" . $from;
    mail($email,$subject,$message, $headers);
}
?>