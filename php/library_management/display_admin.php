<?php
    include 'db.php';

    $query = mysqli_query($con, "SELECT * FROM admin ORDER BY last_name");
    
    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
           
            $list[] = $row;
            
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');
?>