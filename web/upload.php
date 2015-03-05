<?php

if (isset($_POST['uploadButton'])){
    $file = $_FILES['avatarImage']['tmp_name'];
    $fileName = $_FILES['avatarImage']['name'];
    move_uploaded_file($file,"/assets/img/$fileName");
}

?>