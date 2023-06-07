<?php
    include '../db.php';

    $userID = $_POST['userID'];
    $bookID = $_POST['bookID'];
    $contact_no = $_POST['contact_no'];
    $designation = $_POST['designation'];
    $degree = $_POST['degree'];
    $status = "Pending";

    $count = mysqli_query($con, "SELECT COUNT(*) AS count FROM issue_request WHERE userID = '$userID' ");
    $pass = mysqli_fetch_assoc($count);
    if($pass['count'] < 5){
        $duplicate = mysqli_query($con, "SELECT * FROM issue_request WHERE userID = '$userID' && bookID = '$bookID'");
        if(mysqli_num_rows($duplicate) == 0){

            $sql5 = mysqli_query($con, "SELECT * FROM degree WHERE degree = '$degree'");
            $pass5 = mysqli_fetch_assoc($sql5);
            $degree1 = $pass5['degreeID'];
            $query = mysqli_query($con, "INSERT INTO issue_request VALUES('','$userID','$bookID','$contact_no','$designation','$degree1','$status', current_timestamp())");

            if($query){
                echo json_encode("Success");
            }else{
                echo json_encode("Error");
            }
        }else{
            echo json_encode("duplicateIssueRequest");
        }
    }else{
        echo json_encode("Max");
    }   
?>