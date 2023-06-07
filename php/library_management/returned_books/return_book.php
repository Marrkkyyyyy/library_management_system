<?php

	include '../db.php';

	$book_status = $_POST['book_status'];
	$user_school_id = $_POST['user_school_id'];
	$accession_no = $_POST['accession_no'];
	$returned_date = $_POST['returned_date'];

    $return['message'] = "";
    $return['first_name'] = "";
    $return['last_name'] = "";
    $return['middle_name'] = "";
    $return['book_title'] = "";
    $return['fines'] = "";
	$sql1 = mysqli_query($con, "SELECT * FROM users WHERE user_school_id = '$user_school_id'");
    $pass1 = mysqli_fetch_assoc($sql1);
    $userID = $pass1['userID'];
    if(mysqli_num_rows($sql1) == 0){
        $return['message'] = "NoUserIDRegistered";
    }else{

        $sql2 = mysqli_query($con, "SELECT * FROM books WHERE accession_no = '$accession_no'");
        $pass2 = mysqli_fetch_assoc($sql2);
        $bookID = $pass2['bookID'];

        if(mysqli_num_rows($sql2) == 0){
            $return['message'] = "NoAccessionNoRegistered"; 
        }else{
            $sql3 = mysqli_query($con, "SELECT * FROM issue_book WHERE userID = '$userID'");
            if(mysqli_num_rows($sql3) == 0){
                $return['message'] = "noUserIDBorrowed"; 
            }else{
                $sql4 = mysqli_query($con, "SELECT * FROM issue_book WHERE bookID = '$bookID'");
                if(mysqli_num_rows($sql4) == 0){
                    $return['message'] = "noAccesionNoBorrowed";
                }else{
                    $sql5 = mysqli_query($con, "SELECT issue_bookID, issue_book.userID, issue_book.bookID, contact_no, issue_book.designation, degree.degree, issued_date, due_date, degree.degreeID, users.first_name,users.last_name,users.middle_name,books.title FROM (((issue_book INNER JOIN degree ON issue_book.degree = degree.degreeID) INNER JOIN books ON issue_book.bookID = books.bookID) INNER JOIN users ON issue_book.userID = users.userID) WHERE issue_book.userID = '$userID' AND issue_book.bookID = '$bookID'");
                    if(mysqli_num_rows($sql5) == 0){
                        $return['message'] = "DoesNotMatch";  
                    }else{
                        $pass3 = mysqli_fetch_assoc($sql5);
                        $issued_date = $pass3['issued_date'];
                        $due_date = $pass3['due_date'];
                        $issue_bookID = $pass3['issue_bookID'];
                        $designation = $pass3['designation'];
                        $degreeID = $pass3['degreeID'];

                        $sql6 = mysqli_query($con, "SELECT DATEDIFF('$returned_date','$due_date') AS overdue_days");
                        $pass4 = mysqli_fetch_assoc($sql6);
                        $overdue_days = $pass4['overdue_days'] <= '0'? '0': $pass4['overdue_days'];
                        
                        $query = mysqli_query($con, "INSERT INTO returned_books VALUES('','$book_status','$userID','$bookID','$designation','$degreeID','$issued_date','$due_date','$returned_date','$overdue_days','$overdue_days')");
                            
                        if($query){    
                            $return['first_name'] = $pass3['first_name'];
                            $return['last_name'] = $pass3['last_name'];
                            $return['middle_name'] = $pass3['middle_name'];
                            $return['book_title'] = $pass3['title'];
                            $return['fines'] = "$overdue_days";                     
                            mysqli_query($con, "UPDATE books SET availability = 'Available' WHERE bookID = '$bookID'");
                            mysqli_query($con, "DELETE FROM issue_book WHERE issue_bookID = '$issue_bookID'");
                            $return['message'] = "Success"; 
                        }else{
                            $return['message'] = "Error"; 
                        }
                    }
                }
            }
        }
    }
    header('Content-Type: application/json');
    echo json_encode($return);
?>