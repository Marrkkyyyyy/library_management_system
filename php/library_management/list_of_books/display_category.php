<?php
    include '../db.php';

    $query = mysqli_query($con, "SELECT * FROM category ORDER BY category");

    $list = array();
    if($query){
        while($row = mysqli_fetch_assoc($query)){
            $list[] = $row;
        }
        echo json_encode($list);
    }
    header('Content-type: application/json');
?>

