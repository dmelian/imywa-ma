<?php
class mau_form_base {
	
	public $className= 'ma-wdForm';
	public $html;
	public $widgets= array(); // id => array(type, options);
	
	public function OnAction($action, $target, $options, &$response){
		
		switch ($action){
				
			case 'close': //The aplicacion has an closeForm action. And the session a logout action.
				return new mau_form_ajaxResponse( array('command'=>'openLocation', 'location'=>'http://www.google.com') );
				break;
				
			case 'validateField': // Yes it is.
				//TODO: Call to the mysql storeProcedure if needed, and return the validated field and record.
				break;
				
			case 'load':
				$response->html= $this->html;
				$response->widgets= $this->widgets
				
		}
		
		
	}
	
	public function OnOpen($uid, $options, &$response){ and restore.. aunque sea ajax no se trata se una respuesta, hay que cargarlo de nuevo.
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