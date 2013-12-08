<?php
class ma_sys_form extends ma_sql_object {
	public $UId;
	
	public function __construct(){
		parent::__construct();
		$this->UId= $this->newUId();
	}
		
	public function paint($document){
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		if ($source == $this->UId) {
			switch($action){
			case 'init':
				if ( method_exists($this, 'OnLoad') ) $this->OnLoad( $response );
				break;

			default:
				if ( method_exists($this, 'OnAction') ) {
					$this->OnAction($action, $target, $options, $response);
				}
			}
		} else {
			//foreach($this->children as $child) $child->executeAction($action, $source, $target, $options, $response);
		}
	}
	
}
