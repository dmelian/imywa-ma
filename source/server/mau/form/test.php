<?php
class mau_form_start extends mau_form_base{

	public function __construct(){
		parent::__construct();
		
		$form->widgets['continue']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'openForm','form'=>'sys/continue')));
		$form->widgets['test']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'openForm','form'=>'sys/field-test')));
			
		$form->html= '<h1>Formulario de inicio</h1>';
		$form->html.= "<p>Este es el formulario inicial de arranque.</p>";
		$form->html.= "<p>Normalmente será un login con contraseña.</p>";
		$form->html.= '<button id="continue">Continuar</button><br/>';
		$form->html.= '<button id="test">Test</button><br/>';
		
	}
	
	
}