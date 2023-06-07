<?php
    include '../db.php';

    $userID = $_POST['userID'];

    $query = mysqli_query($con, "SELECT issue_request.issueRequestID, issue_request.userID, issue_request.bookID, books.accession_no, books.title, books.author, books.publisher, books.published_year, category.category, books.availability, issue_request.status, issue_request.date, issue_request.contact_no,issue_request.designation,issue_request.degree FROM ((issue_request INNER JOIN books ON issue_request.bookID = books.bookID) INNER JOIN category ON books.categoryID = category.categoryID) WHERE userID = '$userID' ORDER BY status");
    
    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
           
            $list[] = $row;
            
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');
?>