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
	private $sequence= 0;
	private $createTime, $lastRequestTime;
	private $request;
	private $user, $password, $authenticated=false;
	private $apps= array();
	
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
		echo "<p>creating a new session</p>";
		
	
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
		
		if($this->sessionId) {
			setcookie( 'SESSION_ID', $this->sessionId ); //TODO put expires date an others params
			$this->createTime= date('Y-m-d H:i:s');
		}
		
	}

	private function serialize(){
		$sessionFile= new __syncFile( "{$this->sessionDir}/session" );
		if ( !$sessionFile->setContent( serialize( $this ) ) ) {
			//TODO: LOG $sessionFile->errormsg Mensaje 'No se ha podido guardar su sesion'
		}
	}
	
	
	private function initialize(){
		
	}
	
	
	public function OnNewRequest(){

		$this->lastRequestTime= date('Y-m-d H:i:s');
		if (!$this->sessionId) exit( $this->caption('ERR_CREATESESSION') );
		if (!$this->authenticated) $this->authenticate();
		
		if ($this->authenticated) {
			$this->extractRequestProperties();
			if (!$this->sequence){
				//TODO: Initialize the default app and its start form.
				
				$this->sequence++;
			}
			$this->executeRequest();
		}
		$this->serialize();
	}

	private function authenticate(){
		//TODO depending on environment authMethod, authenticated the new session.
		//while the session isn't authenticated, it does not execute any request nor action.
		
		switch ($this->environment['authMethod']){
			
		case 'anonymous':
			$this->user= 'anonymous';
			$this->password= '';
			$this->authenticated= true;
			break;
			
		case 'login':
		case 'http':
			
		default:
			
			echo "The authenticated method {$this->environment['authMethod']} is not already implemented."
			
		}
	}
	
	
	private function extractRequestProperties(){
		
		unset($this->request); $this->request= array();
		$this->request['isAjax']= isset( $_SERVER['HTTP_X_REQUESTED_WITH'] ) 
				? $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest' : false;
		if($this->request['isAjax']) {
			$this->request['ajaxCaller']= isset( $_SERVER['HTTP_REFERER'] ) ? $_SERVER['HTTP_REFERER'] : '';
		}

		$this->request['remoteIp']= $_SERVER['REMOTE_ADDR'];
		$this->request['remotePort']= $_SERVER['REMOTE_PORT'];

		$this->request['action']= substr($_SERVER['SCRIPT_NAME']
				, strrpos( $_SERVER['SCRIPT_NAME'], '/' ) + 1
				, strrpos( $_SERVER['SCRIPT_NAME'], '.' ) - strlen( $_SERVER['SCRIPT_NAME'] ) );
		$this->request['target']= urldecode( 
				substr( $_SERVER['QUERY_STRING'], 0, strpos($_SERVER['QUERY_STRING'], '&') ) 
				);
		$this->request['options']= $_GET;
		if ($this->request['target']) unset($this->request['options'][$this->request['target']]);
		
	}
	
	private function executeRequest(){
		
		echo "<p>New request for session $this->sessionId...</p>";
		echo "<p>Request sequence no. {$this->sequence}</p>";
		echo "<p>Created {$this->createTime} Last Request {$this->lastRequestTime}</p>";
		echo "<pre>" . print_r($this, true) . "</pre>";
		
		
	}
	

}