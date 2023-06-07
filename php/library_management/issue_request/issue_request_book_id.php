<?php
    include '../db.php';
    $issueRequestBookID = $_POST['issueRequestBookID'];
    $issue_request['message'] = "";


    $query = mysqli_query($con, "SELECT issue_request.issueRequestID, users.user_school_id, books.accession_no, issue_request.contact_no, issue_request.designation, degree.degree, issue_request.status, issue_request.userID,issue_request.bookID, degree.degreeID FROM (((issue_request INNER JOIN books ON issue_request.bookID = books.bookID) INNER JOIN users ON issue_request.userID = users.userID) INNER JOIN degree ON issue_request.degree = degree.degreeID) WHERE books.accession_no LIKE '$issueRequestBookID'");
    $pass = mysqli_fetch_assoc($query);
    if(mysqli_num_rows($query) == 0){
        $issue_request['message'] = "NoDataFound";
    }else{
        if($pass['status'] == 'Accepted'){
            $issue_request['message'] = "Accepted";
        }else if($pass['status'] == "Rejected"){
            $issue_request['message'] = "Rejected";
        }else{
            $issue_request['issueRequestID'] = $pass['issueRequestID'];
            $issue_request['user_school_id'] = $pass['user_school_id'];
            $issue_request['accession_no'] = $pass['accession_no'];
            $issue_request['contact_no'] = $pass['contact_no'];
            $issue_request['designation'] = $pass['designation'];
            $issue_request['degree'] = $pass['degree'];
            $issue_request['userID'] = $pass['userID'];
            $issue_request['bookID'] = $pass['bookID'];
            $issue_request['degreeID'] = $pass['degreeID'];
        }
    }
    
   
    
    header('Content-type: application/json');
    echo json_encode($issue_request);
?>