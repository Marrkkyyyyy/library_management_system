<?php
    include 'db.php';

    $bookID = $_POST['bookID'];
    $query = mysqli_query($con, "DELETE FROM books WHERE bookID = '$bookID'");
    
    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }
?>