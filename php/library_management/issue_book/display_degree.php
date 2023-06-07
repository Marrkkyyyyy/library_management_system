<?php
    include '../db.php';

    $designation = $_POST['designation'];

    $query = mysqli_query($con, "SELECT * FROM degree WHERE designation = '$designation' ORDER BY degree");
    
    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
           
            $list[] = $row;
            
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');

    
?>