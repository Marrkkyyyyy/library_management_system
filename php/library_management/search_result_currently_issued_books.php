<?php
    include 'db.php';
    $search = $_POST['search'];

    $query = mysqli_query($con, "SELECT issue_book.issue_bookID, issue_book.contact_no, issue_book.issued_date, issue_book.due_date, users.first_name, users.last_name, users.middle_name, users.user_school_id, books.title, books.accession_no,designation FROM ((issue_book INNER JOIN users ON issue_book.userID = users.userID) INNER JOIN books ON issue_book.bookID = books.bookID) WHERE issue_book.issue_bookID = '$search'");
    
    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }

    header('Content-type: application/json');
?>