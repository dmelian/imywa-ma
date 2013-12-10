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


		if ($source == $this->UId) switch($action){
			case 'init':
				if ( method_exists($this, 'OnLoad') ) $this->OnLoad();
				if ( method_exists($this, 'OnRefresh') ) $this->OnRefresh( $response );
				return true;

			case 'refresh':
				if ( method_exists($this, 'OnRefresh') ) $this->OnRefresh( $response );
				return true;

			default:
				if ( method_exists($this, 'OnAction') ) {
					$catched= $this->OnAction($action, $target, $options );
					if ( method_exists($this, 'OnRefresh') ) $this->OnRefresh( $response );
					return $catched;
					
				} else {
					$class= get_called_class();
					$this->log("ERROR. Form action '{$this->appName}':'$class':'$action' not designed.");
					return false;
				}	


		} else return false;
	}
	
}
