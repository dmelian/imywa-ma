<?php
class mau_response extends mau_media {

	public function __construct($config){
		
	}
	
	public function paint(){
		echo $this->formContent();
	}
	
}