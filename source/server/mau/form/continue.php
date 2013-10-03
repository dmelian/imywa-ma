<?php
class mau_form_continue extends mau_form_base{

	public function __construct(){
		parent::__construct();
		
		$this->widgets['ok']= array('className'=>'ui-button');
		$this->widgets['continue']= array('className'=>'ma-wdButton'
			, 'options'=>array('action'=>array('action'=>'openForm', 'form'=>'mau/form/anotherForm')));
			
		$this->html= '<h1>Formulario de continuación</h1>';
		$this->html.= "<p>Este representa a un formulario normal dentro de la aplicación.</p>";
		$this->html.= '<button id="ok">Aceptar</button><br/>';
		$this->html.= '<button id="continue">Seguir Jugando</button><br/>';
		
		$this->log= 'POST: ' . print_r($_POST, true);
		$this->log.= 'GET: ' . print_r($_GET, true);
		$this->log.= 'SERVER: ' . print_r($_SERVER, true);
		
		
		
		
		
		
		
		
	}
	
	
}