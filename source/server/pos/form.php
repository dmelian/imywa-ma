<?php
class pos_form extends ma_object {
	
	public function initialize(){
		if ( method_exists($this, 'OnLoad') ) $this->OnLoad();
	}
	
	public function paint($document){
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		if ( method_exists($this, 'OnAction') ) $this->OnAction($action, $source, $target, $options);
	}
	
}