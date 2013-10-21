<?php
class ma_ui_form extends ma_ui_container{
	
	public function initialize(){
		
	}
	
	public function executeAction($action, $source, $target, $option, $response){
		
	}
	
	public function paint($document){
		
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
		else $document->addElement('Default Form Paint');
		
	}
	
	
}