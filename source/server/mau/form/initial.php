<?php
class mau_form_initial extends ma_sys_form {

	
	protected function OnPaint($document){
		$document->addElement('Hello, I am the initial form.');
	}
	
	
	
}