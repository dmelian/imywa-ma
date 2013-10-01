<?php
class mau_form_start extends mau_form_base{

	public function __construct(){
		parent::__construct();
		
		$this->widgets['continue']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'openForm','form'=>'sys/continue')));
		$this->widgets['test']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'openForm','form'=>'sys/field-test')));
			
		$this->html= '<h1>Formulario de inicio</h1>';
		$this->html.= "<p>Este es el formulario inicial de arranque.</p>";
		$this->html.= "<p>Normalmente será un login con contraseña.</p>";
		$this->html.= '<button id="continue">Continuar</button><br/>';
		$this->html.= '<button id="test">Test</button><br/>';
		
	}
	
	
}