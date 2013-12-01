<?php
class pos_form extends ma_sql_object {
	protected $UId;
	protected $children= array();
		
	public function initialize(){
		$this->UId= $this->newUId();
		if ( method_exists($this, 'OnLoad') ) $this->OnLoad();
		foreach($this->children as $child) $child->initialize();
	}
	
	public function paint($document){
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
		else foreach($this->children as $child) $child->paint($document);
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		if ($source == $this->UId) {
			if ( method_exists($this, 'OnAction') ) $this->OnAction($action, $target, $options, $response);
		} else {
			foreach($this->children as $child) $child->executeAction($action, $source, $target, $options, $response);
		}
	}
	
}
