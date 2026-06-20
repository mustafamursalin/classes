<?php

if(isset($_GET['page'])){
    $page = $_GET['page'];

    if($page == 'dashboard' || $page == 'dashboard.php'){
        include_once 'views/pages/dashboard.php';
    }
    elseif($page == 'form' || $page == 'form.php'){
        include_once 'views/pages/form.php';
    }
    elseif($page == 'table' || $page == 'table.php'){
        include_once 'views/pages/table.php';
    }
    elseif($page == 'patients'){
        include_once 'views/pages/patients/manage.php';
    }
    elseif($page == 'create-patient'){
        include_once('views/pages/patients/create.php');
    }
    elseif($page == 'edit-patient'){
        include_once('views/pages/patients/edit.php');
    }
    elseif($page == 'doctors'){
        include_once 'views/pages/doctors/manage.php';
    }
    elseif($page == 'create-doctor'){
        include_once('views/pages/doctors/create.php');
    }
    elseif($page == 'edit-doctor'){
        include_once('views/pages/doctors/edit.php');
    }
    else{
        include_once 'views/pages/dashboard.php';
    }
}
else{
        include_once 'views/pages/dashboard.php';
}

?>