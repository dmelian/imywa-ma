<?php

class __syncFile {

	public $errorno;
	public $content;
	public $filename;
	
	public function __construct($filename){ $this->filename= $filename; }
	
	public function getContent(){

		if (file_exists($this->filename)) {
			if ($file= fopen($this->filename,'r')){
				
				$count = 0;
				while ((!$lock = flock($file,LOCK_EX)) && $count < 10){ usleep(50000); $count++; }
				
				if ($lock) {
					 
					fseek($file,0); $this->content= fread($file, filesize($this->filename));
					flock($file,LOCK_UN); fclose($file);
					return true;
					
				} else $this->errorno = "LOCKFILEERROR";
			} else $this->errorno= "OPENFILEERROR";
		} else $this->errorno = "FILENOTFOUND";
		 
		return false; 
	}

	
	function setContent($content){

		$newfile= !file_exists($this->filename);
		if ($file= fopen($this->filename,'c+')){

			$count = 0;
			while ((!$lock = flock($file,LOCK_EX)) && $count < 10){ usleep(50000); $count++; }
			
			if ($lock) {
				 
				fseek($file,0); fwrite($file, $content);
				flock($file,LOCK_UN); fclose($file);
				if ($newfile) chmod($this->filename, 0666);
				return true;
				
			} else $this->errorno = "LOCKFILEERROR";
		} else $this->errorno = "CREATEFILEERROR"; 
		
		return false; 
	}

}



class ma_sys_session extends ma_object {
	
	private $environment;
	private $sessionId, $sessionDir;
	
	public static function create($environment) {
		
		if ( $sessionId= isset( $_COOKIE['SESSION_ID'] ) ? $_COOKIE['SESSION_ID'] : '' ){
			$sessionDir = "{$environment['usrDir']}/run/sessions/$sessionId";
			$sessionFile= new __syncFile("$sessionDir/session");
			if ($sessionFile->getContent()) return unserialize($sessionFile->content);
			else ;//TODO Else LOG a request without file or anything error.
		}
		return new ma_sys_session($environment);


	}
	
	
	
	public function __construct($environment){
		parent::__construct();
		$this->environment= $environment;
		echo "session.constructor";
		
	
		// Create the session folder
		$sessionbasedir = "{$environment['usrDir']}/run/sessions/";
		if (!file_exists($sessionbasedir)){
			mkdir($sessionbasedir); chmod($sessionbasedir, 0777);
		}

		$attemps= 0; $sessionId= '';
		do {
			$this->sessionId= uniqid('X');
			$this->sessionDir= "$sessionbasedir{$this->sessionId}";
			if (!file_exists($this->sessionDir)){
				$success= mkdir($this->sessionDir); 
				if ($success) $success= chmod($this->sessionDir, 0777);
				if ($success) $success= mkdir($this->sessionDir."/temp");
				if ($success) $success= chmod($this->sessionDir."/temp", 0777);
				if (!$success) $this->sessionId= '';
			} else  $this->sessionId= '';
		} while (!$this->sessionId && ($attemps++ < 5));
		
		if($this->sessionId) setcookie( 'SESSION_ID', $this->sessionId ); //TODO put expires date an others params
		
	}

	
	public function initialize(){
		if($isAjax= isset( $_SERVER['HTTP_X_REQUESTED_WITH'] ) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
			$ajaxCaller= isset( $_SERVER['HTTP_REFERER'] ) ? $_SERVER['HTTP_REFERER'] : '';
		}
		
	}
	
	
	public function OnNewRequest(){
		if (!$this->sessionId) exit( $this->caption('ERR_CREATESESSION') );
		echo "<p>New request for session $this->sessionId...</p>"; 
	}



}