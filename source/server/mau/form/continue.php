<?php
class mau_form_continue extends ma_ui_form {

	public function executeAction($action, $source, $target, $option, $response){
		
		switch($action){
		case 'refresh':
			$this->OnPaint($response);
			break;
		}
	
	}
	
	protected function OnPaint($document){
	
		$document->addHtml('<h1>Formulario de continuación</h1>');
		$document->addHtml('<p>Este representa a un formulario normal dentro de la aplicación.</p>');
		$document->addHtml('<button id="ok">Aceptar</button><br/>');
		$document->addHtml('<button id="continue">Seguir Jugando</button><br/>');
	
		$document->addWidget('continue', 'ma-wdButton', array('action'=>array('action'=>'openForm','target'=>'mau/form/anotherForm')));
		$document->addWidget('ok', 'ui-button');
	
	}
	
	
	
}