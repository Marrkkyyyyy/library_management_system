<?php
	include '../db.php';

	$query = mysqli_query($con, "SELECT issue_book.issue_bookID, contact_no, issue_book.designation, degree.degree, issued_date, due_date, DATEDIFF(CURRENT_DATE, due_date) AS overdue_days, DATEDIFF(CURRENT_DATE, due_date) AS fines, users.user_school_id,users.first_name,users.last_name,users.middle_name, books.title,books.accession_no,books.availability FROM (((issue_book INNER JOIN users ON issue_book.userID = users.userID) INNER JOIN books ON issue_book.bookID = books.bookID) INNER JOIN degree ON issue_book.degree = degree.degreeID) WHERE availability = 'Not Available'");

	$list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');

?>