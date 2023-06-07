<?php
    include '../db.php';

    $query = mysqli_query($con, "SELECT returned_books.returned_bookID, returned_books.book_status, returned_books.designation, degree.degree, returned_books.issued_date, returned_books.due_date, returned_books.returned_date, returned_books.overdue_days, returned_books.fines, users.user_school_id, users.first_name, users.last_name, users.middle_name, books.title, books.accession_no FROM (((returned_books INNER JOIN users ON returned_books.userID = users.userID) INNER JOIN books ON returned_books.bookID = books.bookID) INNER JOIN degree ON returned_books.degree = degree.degreeID) ORDER BY returned_books.returned_bookID DESC");

    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');
?>

