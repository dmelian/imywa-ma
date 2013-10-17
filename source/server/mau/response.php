<?php
class mau_response {
	
	public $html;
	public $className= 'ma-wdForm';
	
	public $widgets= array(); // id => array(type, options);

	public function __construct($config){
		
	}
	
	public function paint(){
		echo json_encode($this);
	}
	
}