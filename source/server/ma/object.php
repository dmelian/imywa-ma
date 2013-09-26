<?php
 
class ma_object{

	
	public function __construct() {
		$this->loadTexts( get_called_class() );
	}
	
	protected function loadTexts($id, $fileName=''){
		global $_MANAGER;
		
		if ( !$fileName ) {
			/* By default there are only one text file for one source dir. Every file has a section inside */
			$ids= array_slice( explode( '_', $id ), 0, -1 );
			$id= implode( '_', $ids ); 
			$fileName= implode( '/', $ids );
		}
		$fileName= "{$_MANAGER->environment['usrDir']}/data/texts/$fileName";
		if ( is_dir( $fileName ) ) $fileName.= "/default";
		$_MANAGER->texts->loadFile( $id, "$fileName.{$_MANAGER->environment['language']}" );
	}
	
	protected function caption( $id, $params='' ){ 
		global $_MANAGER; return
		
		$_MANAGER->texts->getCaption( get_called_class() . "_$id", $params ); 
	}
	
	protected function description( $id='', $params='' ){ 
		global $_MANAGER;
		
		return $_MANAGER->texts->getDescription( get_called_class() . "_$id", $params ); 
	}
	
}