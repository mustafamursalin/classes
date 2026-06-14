<?php
class User
{
    public $id;
    public $name;
    public $email;
    public $role_id;
    private $password;

    public function __construct($_id, $_name, $_email, $_role_id, $_password = null) {
        $this->id = $_id;
        $this->name = $_name;
        $this->email = $_email;
        $this->role_id = $_role_id;
        $this->password = $_password;
    }

    public function create(){
        
    }
    public function update(){

    }
    public function readAll(){

    }
    public function readByID(){

    }
    public function delete(){

    }

}




?>