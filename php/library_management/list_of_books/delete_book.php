<?php
    include '../db.php';

    $bookID = $_POST['bookID'];
    $query = mysqli_query($con, "DELETE FROM books WHERE bookID = '$bookID'");
    
    if($query){
        echo json_encode("Success");
        mysqli_query($con, "DELETE FROM issue_book WHERE bookID = '$bookID'");
        mysqli_query($con, "DELETE FROM issue_request WHERE bookID = '$bookID'");
    }else{
        echo json_encode("Error");
    }
?>