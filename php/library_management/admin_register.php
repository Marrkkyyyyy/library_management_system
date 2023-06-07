<?php
    include 'db.php';


    $middle_initial = $_POST['middle_name'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $duplicateEmailStudent = mysqli_query($con, "SELECT * FROM users WHERE email = '$email'");
    $duplicateEmailAdmin = mysqli_query($con, "SELECT * FROM admin WHERE email = '$email'");
   


    if(mysqli_num_rows($duplicateEmailStudent) > 0){
        echo json_encode("duplicateEmail");
    }else if(mysqli_num_rows($duplicateEmailAdmin) > 0){
        echo json_encode("duplicateEmail");
    }else{
        $query = mysqli_query($con, "INSERT INTO admin VALUES('','$first_name','$last_name','$middle_initial','$email','$password')");

        if($query){
            echo json_encode("Success");
        }else{
            echo json_encode("Error");
        }
   
    }


?>