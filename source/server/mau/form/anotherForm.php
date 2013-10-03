<?php
class mau_form_anotherForm extends mau_form_base{

	public function __construct(){
		parent::__construct();
		
		$this->widgets['logout']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'close')));
		$this->html= '<h1>Fin de la aplicación</h1>';
		$this->html.='<button id="logout">Salir</button>';
		
		
	}
	
	
}