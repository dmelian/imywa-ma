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
		$myfilename= "$fileName.{$_MANAGER->environment['language']}";
		$_MANAGER->texts->loadFile( $id, "$fileName.{$_MANAGER->environment['language']}" );
	}
	
	protected function caption( $id, $params='', $local=true ){
		global $_MANAGER; 
		
		$module= $local ? get_called_class() . '_' : '';
		return $_MANAGER->texts->getCaption( "$module$id", $params ); 
	}
	
	protected function description( $id='', $params='', $local=true ){ 
		global $_MANAGER;
		
		if ( $id ){
			$module= $local ? get_called_class() . '_' : '';
			return $_MANAGER->texts->getDescription( "$module$id", $params );
			
		} else return $_MANAGER->texts->getLastIdDescription();
	}

	
// LOGS
	
	protected function log($msg, $section='log', $comment= ''){
		//TODO Select section type (prefix / file)
		global $_MANAGER;
		
		if (!$section) $section= 'log';
		
		switch ($_MANAGER->environment['logType']){
		case 'file':
			$filename= "{$_MANAGER->environment['usrDir']}/run/log";
			$prefix= "$section [" . gmdate('Y-m-d H:i:s') . '] ';
			break;
		case 'directory': 
			$filename= "{$_MANAGER->environment['usrDir']}/run/log/$section";
			$prefix= gmdate('Y-m-d H:i:s') . ' ';
			break;
		}
		
		if (!file_exists($filename)){ $fp= fopen($filename, 'a+'); chmod($filename, 0666); } 
		else $fp= fopen($filename, 'a');
		
		if ( is_array($msg) || is_object($msg) ) {
			if (!$comment) $comment= '--';
			$msg= strtr( "$comment\n" . print_r( $msg, TRUE ), array( "\n" => "\n\t" ) );
		} else {
			if ($comment) $comment= "[$comment]:";
			$msg= strtr( $comment.$msg, array( "\n" => "\n\t" ) );
		}
		
		fwrite($fp, "$prefix$msg\n");
		fclose($fp);
	}
	
	//TODO debug better on session dir.
	protected function debug($var, $comment='') { $this->log($var, 'debug', $comment); }
	
// UIDS

	protected function newUId(){ global $_MANAGER; return $_MANAGER->currentSession->newUId(); }

	public function setGlobal($key, $value){ global $_MANAGER; $_MANAGER->setGlobal($key, $value); }
	public function getGlobal($key){ global $_MANAGER; $_MANAGER->getGlobal($key); }
	protected function getGlobals(){ global $_MANAGER; return $_MANAGER->currentSession->getGlobals(); }
}
