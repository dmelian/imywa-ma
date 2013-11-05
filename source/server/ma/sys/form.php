<?php
class ma_sys_form extends ma_object{
	
	public function paint($document){
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		
	}
	
}