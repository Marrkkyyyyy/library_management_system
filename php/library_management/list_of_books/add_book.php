<?php
    include '../db.php';

    $title = $_POST['title'];
    $author = $_POST['author'];
    $publisher = $_POST['publisher'];
    $published_year = $_POST['published_year'];
    $accession_no = $_POST['accession_no'];
    $categoryID = $_POST['categoryID'];
    $notes = $_POST['notes'];
    $availability = "Available";
    
    $sql = mysqli_query($con, "SELECT * FROM books WHERE accession_no = '$accession_no'");
    if(mysqli_num_rows($sql) == 0){
        $query = mysqli_query($con, "INSERT INTO books VALUES('','$title','$author','$publisher','$published_year','$accession_no','$categoryID','$notes','$availability')");

        if($query){
            echo json_encode("Success");
        }else{
            echo json_encode("Error");
        }
    }else{
        echo json_encode("duplicateAccessionNo");
    }
    
?>