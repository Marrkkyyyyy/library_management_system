<?php
    include '../db.php';
 
    mysqli_query($con, "DELETE FROM issue_request WHERE issueRequestID IN (SELECT issueRequestID FROM (SELECT *, DATEDIFF(issue_request.date,CURRENT_DATE()) AS expiration FROM issue_request HAVING expiration <= -2 AND status != 'Pending') AS p)
        ");

?>