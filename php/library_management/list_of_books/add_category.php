<?php
    include '../db.php';

    $category = $_POST['category'];
    $query = mysqli_query($con, "INSERT INTO category VALUES('','$category')");
    
    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>