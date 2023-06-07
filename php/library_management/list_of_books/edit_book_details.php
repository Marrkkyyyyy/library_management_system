<?php
    include '../db.php';
    
    $bookID = $_POST['bookID'];
    $title = $_POST['title'];
    $author = $_POST['author'];
    $publisher = $_POST['publisher'];
    $published_year = $_POST['published_year'];
    $accession_no = $_POST['accession_no'];
    $notes = $_POST['notes'];

    $sql1 = mysqli_query($con, "SELECT * FROM books WHERE bookID = '$bookID'");


    
    $query = mysqli_query($con, "UPDATE books SET title = '$title', author = '$author', publisher = '$publisher', published_year = '$published_year', accession_no = '$accession_no',notes = '$notes' WHERE bookID = '$bookID'");
    
    if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }

    

   
?>