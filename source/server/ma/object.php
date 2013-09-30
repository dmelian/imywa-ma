<?php
 
class ma_object{

	
	public function __construct() {
		$this->loadTexts( get_called_class() );
	}


// TEXTS	
	
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

	
// LOGS
	
	protected function log($msg, $section='log', $comment= ''){
		//TODO Select section type (prefix / file)
		global $_MANAGER;
		
		if (!$section) $section= 'log';
		
		switch ($_MANAGER->environment['logType']){
		case 'file':
			$filename= "{$_MANAGER->environment['usrDir']}/run/log";
			$prefix= "$section [" . gmdate('Y-m-d H:i:s') . "]:\t";
			break;
		case 'directory': 
			$filename= "{$_MANAGER->environment['usrDir']}/run/log/$section";
			$prefix= gmdate('Y-m-d H:i:s') . ":\t";
			break;
		}
		
		if (!file_exists($filename)){ $fp= fopen($filename, 'a+'); chmod($filename, 0666); } 
		else $fp= fopen($filename, 'a');
		
		if (!$comment) $comment= '--';
		if ( is_array($msg) || is_object($msg) ) {
			$msg= strtr( "$comment\n" . print_r( $msg, TRUE ), array( "\n" => "\n\t" ) );
		} else $msg= strtr( $msg, array( "\n" => "\n\t" ) );
		
		fwrite($fp, "$prefix$msg\n");
		fclose($fp);
	}
	
	protected function debug($var, $comment='') { $this->log($var, 'debug', $comment); }
	
}