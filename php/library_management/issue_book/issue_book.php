<?php
    include '../db.php';

    $user_school_id = $_POST['user_school_id'];
    $accession_no = $_POST['accession_no'];
    $contact_no = $_POST['contact_no'];
    $designation = $_POST['designation'];
    $degree = $_POST['degree'];
    $issued_date = $_POST['issued_date'];

    $sql1 = mysqli_query($con, "SELECT * FROM users WHERE user_school_id = '$user_school_id'");
    $pass1 = mysqli_fetch_assoc($sql1);
    $userID = $pass1['userID'];
    if(mysqli_num_rows($sql1) == 0){
        echo json_encode("NoUserID");
    }else{

        $sql2 = mysqli_query($con, "SELECT * FROM books WHERE accession_no = '$accession_no'");
        $pass2 = mysqli_fetch_assoc($sql2);
        $bookID = $pass2['bookID'];

        if(mysqli_num_rows($sql2) == 0){
            echo json_encode("NoAccessionNo");
        }else{
            $sql3 = mysqli_query($con, "SELECT * FROM issue_book WHERE userID = '$userID'");

            if(mysqli_num_rows($sql3) >= 3){
                echo json_encode("Max");
            }else{
                $sql4 = mysqli_query($con, "SELECT * FROM books WHERE bookID = '$bookID'");
                $pass4 = mysqli_fetch_assoc($sql4);
                $availability = $pass4['availability'];

                if($availability != 'Available'){
                    echo json_encode("NotAvailable");
                }else{
                    $sql5 = mysqli_query($con, "SELECT * FROM degree WHERE degree = '$degree'");
                    $pass5 = mysqli_fetch_assoc($sql5);
                    $degree1 = $pass5['degreeID'];

                    $query = mysqli_query($con, "INSERT INTO issue_book VALUES('','$userID','$bookID','$contact_no','$designation','$degree1','$issued_date', DATE_ADD('$issued_date', INTERVAL 03 DAY))");
           
                    if($query){
                        mysqli_query($con, "UPDATE books SET availability = 'Not Available' WHERE bookID = '$bookID'");
                        echo json_encode("Success");
                    
                    }else{
                        echo json_encode("Error");
                    }
                }
            }
        }
    }   
?>
