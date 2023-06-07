<?php
	include '../db.php';

	$query = mysqli_query($con, "SELECT issue_request.issueRequestID, issue_request.userID, issue_request.bookID, issue_request.contact_no, issue_request.designation, issue_request.degree, issue_request.status,issue_request.date, users.user_school_id, users.first_name, users.last_name, users.middle_name, books.accession_no, books.title, books.availability, degree.degree FROM (((issue_request INNER JOIN users ON issue_request.userID = users.userID) INNER JOIN books ON issue_request.bookID = books.bookID) INNER JOIN degree ON issue_request.degree = degree.degreeID)");

	$list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');

?>