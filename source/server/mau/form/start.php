<?php
class mau_form_start extends ma_ui_form{

	
	
	protected function OnPaint($document){
		
		$document->addHtml('<h1>Formulario de inicio</h1>');
		$document->addHtml('<p>Este es el formulario inicial de arranque.</p>');
		$document->addHtml('<p>Normalmente será un login con contraseña.</p>');
		$document->addHtml('<button id="continue">Continuar</button><br/>');
		$document->addHtml('<button id="test">Test</button><br/>');
		
		$document->addWidget('continue', 'ma-wdButton', array('action'=>array('action'=>'openForm','form'=>'mau/form/continue')));
		$document->addWidget('test', 'ma-wdButton', array('action'=>array('action'=>'openForm','form'=>'mau/form/fieldTest')));
		
	}
	
}
