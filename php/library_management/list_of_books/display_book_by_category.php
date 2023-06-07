<?php
    include '../db.php';
    $categoryID = $_POST['categoryID'];
    $query = mysqli_query($con, "SELECT bookID,title,author,publisher,published_year,accession_no,notes, availability, category.category FROM books INNER JOIN category ON books.categoryID = category.categoryID WHERE books.categoryID = '$categoryID' ORDER BY title");

    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');
?>