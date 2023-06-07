<?php
	include 'db.php';

	$userID = $_POST['userID'];
	$bookID = $_POST['bookID'];

	$query = mysqli_query($con, "SELECT issue_book.issue_bookID, issue_book.contact_no, issue_book.issued_date, issue_book.due_date, users.first_name, users.last_name, users.middle_name, users.user_school_id, books.title, books.accession_no FROM ((issue_book INNER JOIN users ON issue_book.userID = users.userID) INNER JOIN books ON issue_book.bookID = books.bookID) WHERE books.title LIKE '$search' OR users.user_school_id LIKE '$search'");

	if($query){
        echo json_encode("Success");
    }else{
        echo json_encode("Error");
    }

?>