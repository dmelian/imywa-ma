<?php
class mau_form_base extends ma_frm_form{
	
	public $responseType= 'auto';
	
	public $html;
	public $className= 'ma-wdForm';
	
	public $widgets= array(); // id => array(type, options);
	public $log;
	
	public function encode() { return json_encode($this); }
	
	public function OnAction($action, $target, $options){
		
		switch ($action){
			case 'openForm':  //do not execute. This is an application action.
				global $_MANAGER;
				echo "<p>Este es el caballo que viene de Bonanza</p>";
				echo "<pre>".print_r($_MANAGER, true)."</pre>";
				echo "<pre>".$this->encode()."</pre>";
				break;
				
			case 'close': //The aplicacion has an closeForm action. And the session a logout action.
				echo json_encode(array('command'=>'openLocation', 'location'=>'http://www.google.com'));
				break;
				
			case 'validateField': // Yes it is.
				//TODO: Call to the mysql storeProcedure if needed, and return the validated field and record.
				break;
				
		}
		
		//TODO openForm and close are application actions. validateField is form or record action. Where are the ids?.
		
	}
	
	public function OnOpen($uid, $options){
		return $this;
	}
	
	public function OnPaint($config){
		
		if ($config['isAjax']) {
			echo $this->encode(); //WHAT HAPPEND WITH THE OPTIONAL SCRIPT.
			
		} else {
			$page= new mau_form_html($config);
			$page->paint($this);
			
		}
	}
	
}