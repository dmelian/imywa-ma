<?php
class mau_response extends mau_media {

	private $response= array();
	
	public function add ($destination, $command, $options){
		//The response has 3 attributes, destination-id, command (method-id), options.
		//( The request has 4 action (method), source, target, options ).
		$this->response[]= array('destination'=> $destination, 'command'=> $command, 'options'=> $options);
	}
	
	public function __construct($config){
		
	}
	
	public function paint(){
		echo $this->formContent();
	}
	
}