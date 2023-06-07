<?php
    include 'db.php';

    $userID = $_POST['userID'];

    $query = mysqli_query($con, "SELECT returned_books.*, books.accession_no, books.title FROM returned_books INNER JOIN books ON returned_books.bookID = books.bookID WHERE userID = '$userID'");

    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }

    header('Content-type: application/json');
?>