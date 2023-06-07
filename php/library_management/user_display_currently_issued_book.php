<?php
    include 'db.php';

    $userID = $_POST['userID'];

    $query = mysqli_query($con, "SELECT issue_book.*, books.title, books.accession_no, DATEDIFF(CURRENT_DATE(),due_date) AS overdue_days,DATEDIFF(CURRENT_DATE(),due_date) AS fines  FROM issue_book INNER JOIN books ON issue_book.bookID = books.bookID WHERE issue_book.userID = '$userID'");

    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }

    header('Content-type: application/json');
?>