<?php
    include 'db.php';

    $email = $_POST['email'];
    $password = $_POST['password'];
    $login['message'] = "";
    $queryAdmin = mysqli_query($con, "SELECT * FROM admin WHERE email = '$email'");
    $queryStudent = mysqli_query($con, "SELECT * FROM users WHERE email = '$email'");

    if(mysqli_num_rows($queryAdmin) > 0){
        $pass1 = mysqli_fetch_assoc($queryAdmin);
        if($password == $pass1['password']){
            $login['message'] = "SuccessAdmin";

            $login['adminID'] = $pass1['adminID'];
            $login['first_name'] = $pass1['first_name'];
            $login['last_name'] = $pass1['last_name'];
            $login['middle_name'] = $pass1['middle_name'];
            $login['email'] = $pass1['email'];
            $login['password'] = $pass1['password'];
        }else{
            $login['message'] = "IncorrectPassword";
        }
    }else if(mysqli_num_rows($queryStudent) > 0){
            
        $pass2 = mysqli_fetch_assoc($queryStudent);
        if($password == $pass2['password']){
            $login['message'] = "SuccessStudent";

            $login['userID'] = $pass2['userID'];
            $login['first_name'] = $pass2['first_name'];
            $login['last_name'] = $pass2['last_name'];
            $login['middle_name'] = $pass2['middle_name'];
            $login['email'] = $pass2['email'];
            $login['password'] = $pass2['password'];
        }else{
            $login['message'] = "IncorrectPassword";
        }
    
    }else{
        $login['message'] = "NotRegistered";
    }


    header('Content-Type: application/json');
    echo json_encode($login);
?>