<?php
class mau_response extends mau_media {

	private $response= array();
	
	public function add ($response){
		$this->response[]= $response;
	}
	
	public function __construct($config){
		
	}
	
	public function paint(){
		echo $this->formContent();
	}
	
}