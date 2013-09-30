<?php
class mau_form_base extends ma_frm_form{
	
	public $html;
	public $className= 'ma-wdForm';
	
	public $widgets= array(); // id => array(type, options);
	public $log;
	
	public function encode() { return json_encode($this); }
	
	public function OnAction($action, $target, $options){
		
		switch ($action){
			case 'openForm':  
				echo $this->encode();
				break;
				
			case 'close':
				echo json_encode(array('command'=>'openLocation', 'location'=>'http://www.google.com'));
				break;
				
			case 'validateField':
				//TODO: Call to the mysql storeProcedure if needed, and return the validated field and record.
				break;
				
		}
		
		//TODO openForm and close are application actions. validateField is form or record action. Where are the ids?.
		
	}
	
}