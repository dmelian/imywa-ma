<?php
class mau_form_test extends mau_form_base{

	public function __construct(){
		parent::__construct();
		
		$this->widgets['continue']= array('className'=>'ui-button');
		$this->widgets['pause']= array('className'=>'ui-button');
		$this->widgets['restore']= array('className'=>'ui-button','options'=>array('disabled'=>true));
		$this->widgets['mabutton']= array('className'=>'ma-wdButton');
		$this->widgets['login']= array('className'=>'ma-wdTextBox');
		$this->widgets['login1']= array('className'=>'ma-wdTextBox');
		$this->widgets['login2']= array('className'=>'ma-wdTextBox');
		
		$this->html= '<h1>Formulario 1</h1>';
		$this->html.= '<p>Este es un formulario descargado de internet</p>';
		$this->html.= '<button id="continue">Continue</button><br/>';
		$this->html.= '<button id="pause">Pause</button><br/>';
		$this->html.= '<button id="restore">Restore database</button><br/>';
		$this->html.= '<button id="mabutton">Custom Button</button><br/>';
		$this->html.= '<input id="login" /><br/>';
		$this->html.= '<input id="login1" /><br/>';
		$this->html.= '<input id="login2" /><br/>';
		
	}
	
	
}