<?php
    include '../db.php';
    $issueRequestID = $_POST['issueRequestID'];
    $user_school_id = $_POST['user_school_id'];
    $bookID = $_POST['accession_no'];
    $degreeID = $_POST['degreeID'];
    $designation = $_POST['designation'];
    $contact_no = $_POST['contact_no'];
    $issued_date = $_POST['issued_date'];
 

    $sql1 = mysqli_query($con, "SELECT * FROM users WHERE user_school_id = '$user_school_id'");
    $pass1 = mysqli_fetch_assoc($sql1);
    $userID = $pass1['userID'];

    $sql2 = mysqli_query($con, "SELECT * FROM books WHERE bookID = '$bookID'");
    $pass2 = mysqli_fetch_assoc($sql2);
    $availability = $pass1['availability'];
    if(mysqli_num_rows($sql1) == 0){   
        echo json_encode("NoUserID");   
    }else{
        $sql2 = mysqli_query($con, "SELECT * FROM issue_request WHERE userID = '$userID' AND bookID = '$bookID'");
        if(mysqli_num_rows($sql2) == 0){
            echo json_encode("DoesNotMatch");  
        }else{
            if($availability == 'Available'){
                $query = mysqli_query($con, "INSERT INTO issue_book VALUES('','$userID','$bookID','$contact_no','$designation','$degreeID','$issued_date', DATE_ADD('$issued_date', INTERVAL 03 DAY))");

                if($query){
                    mysqli_query($con, "UPDATE books SET availability = 'Not Available' WHERE bookID = '$bookID'");
                    mysqli_query($con, "UPDATE issue_request SET status = 'Accepted', date = '$issued_date' WHERE issueRequestID = '$issueRequestID'");
                    echo json_encode("Success"); 
                }else{
                    echo json_encode("Error"); 
                }
            }else{
                echo json_encode("NotAvailable"); 
            }
        }

     }   
?>
