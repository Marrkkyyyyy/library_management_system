<?php
    include 'db.php';

    $user_school_id = $_POST['user_school_id'];
    $middle_initial = $_POST['middle_initial'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $duplicateID = mysqli_query($con, "SELECT * FROM users WHERE user_school_id = '$user_school_id'");
    $duplicateEmailStudent = mysqli_query($con, "SELECT * FROM users WHERE email = '$email'");
    $duplicateEmailAdmin = mysqli_query($con, "SELECT * FROM admin WHERE email = '$email'");
   


    if(mysqli_num_rows($duplicateID) > 0){
        echo json_encode("duplicateID");
    }else if(mysqli_num_rows($duplicateEmailStudent) > 0){
        echo json_encode("duplicateEmail");
    }else if(mysqli_num_rows($duplicateEmailAdmin) > 0){
        echo json_encode("duplicateEmail");
    }else{
        $query = mysqli_query($con, "INSERT INTO users VALUES('','$user_school_id','$first_name','$last_name','$middle_initial','$email','$password')");

        if($query){
            echo json_encode("Success");
        }else{
            echo json_encode("Error");
        }
   
    }


?>