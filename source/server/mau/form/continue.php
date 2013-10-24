<?php
class mau_form_continue extends ma_ui_form {

/*	public function executeAction($action, $source, $target, $option, $response){
		
		switch($action){
		case 'refresh':
			$this->OnPaint($response);
			break;
		}
	
	}
*/	
	
	private function paintme($media){
		$media->addHtml('<h1>Formulario de continuación</h1>');
		$media->addHtml('<p>Este representa a un formulario normal dentro de la aplicación.</p>');
		$media->addHtml('<button id="ok">Aceptar</button><br/>');
		$media->addHtml('<button id="continue">Seguir Jugando</button><br/>');
	
		$media->addWidget('continue', 'ma-wdButton', array('action'=>array('action'=>'openForm','target'=>'mau/form/anotherForm')));
		$media->addWidget('ok', 'ui-button');
		
	}
	
	public function OnOpen($options, $response){
		$media= new mediaordocument();
		$this->paintme($media);
		$response->add($sourceid, 'loadForm', $media->paintForm());
		
	}
	
	public function OnPaint($document){
		$this->paintme($document);
		
	}
		
	
	
}