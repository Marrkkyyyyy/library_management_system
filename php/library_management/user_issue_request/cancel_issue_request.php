<?php
    include '../db.php';

    $issueRequestID = $_POST['issueRequestID'];
    $query = mysqli_query($con, "DELETE FROM issue_request WHERE issueRequestID = '$issueRequestID'");
    
    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>