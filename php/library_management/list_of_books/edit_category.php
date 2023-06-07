<?php
    include '../db.php';
    
    $categoryID = $_POST['categoryID'];
    $category = $_POST['category'];
    
    $query = mysqli_query($con, "UPDATE category SET category = '$category' WHERE categoryID = '$categoryID'");
    
    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }

    

   
?>