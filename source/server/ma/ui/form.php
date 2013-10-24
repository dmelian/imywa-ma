<?php
class ma_ui_form extends ma_ui_container{
	
	public function initialize(){
		
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		$this->debug($action, 'form. executeAction. Action');
		$this->debug($source, 'Source');
		$this->debug($target, 'Target');
		$this->debug($options, 'Options');
		$this->debug($response, 'Response');
		
	}
	
	public function paint($document){
		
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
		else $document->addElement('Default Form Paint');
		
	}
	
	
}