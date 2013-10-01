<?php

class ma_sys_session extends ma_object {
	
	private $environment;
	private $sessionId, $sessionDir;
	private $sequence= 0;
	private $createTime, $lastRequestTime;
	private $request; //Current request data (asoc array)
	private $user, $password, $authenticated=false;
	private $apps= array();
	private $currentApp;
	
	public static function create($environment) {
		
		if ( $sessionId= isset( $_COOKIE['SESSION_ID'] ) ? $_COOKIE['SESSION_ID'] : '' ){
			$sessionDir = "{$environment['usrDir']}/run/sessions/$sessionId";
			$sessionFile= new ma_lib_syncFile("$sessionDir/session");
			if ($sessionFile->getContent()) return unserialize($sessionFile->content);
			else ;//TODO Else LOG a request without file or anything error.
		}
		return new ma_sys_session($environment);


	}
	
	
	
	public function __construct($environment){
		parent::__construct();
	
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
			$this->environment= $environment;
			$this->environment['sessionDir']= $this->sessionDir;
			$this->log("Session {$this->sessionId} created");
		}
		
	}

	private function serialize(){
		
		$sessionFile= new ma_lib_syncFile( "{$this->sessionDir}/session" );
		if ( !$sessionFile->setContent( serialize( $this ) ) ) {
			//TODO: LOG $sessionFile->errormsg Mensaje 'No se ha podido guardar su sesion'
		}
	}
	
	
	
	public function OnNewRequest(){
		
		$this->lastRequestTime= date('Y-m-d H:i:s');
		if (!$this->sessionId) {
			//TODO LOG create session error.
			exit( $this->caption('ERR_CREATESESSION') );
		}
		if (!$this->authenticated) $this->authenticate();
		
		if ($this->authenticated) {
			$this->extractRequestProperties();
			if (!$this->currentApp){
				$startApp= $this->startDefaultApplication();
				$this->apps[$startApp->appName]= $startApp;
				$this->currentApp=$startApp->appName; 
			}
			
			$this->sequence++;
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
			
			echo "The authenticated method {$this->environment['authMethod']} is not already implemented.";
			
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
		if (($targetEnd= strpos($_SERVER['QUERY_STRING'], '&')) !== false ){
			$this->request['target']= urldecode( substr( $_SERVER['QUERY_STRING'], 0, $targetEnd ));
		} else {
			$this->request['target']= urldecode( $_SERVER['QUERY_STRING'] ); 
		}
		$this->request['options']= array_merge($_GET, $_POST);
		if ($this->request['target']) unset($this->request['options'][$this->request['target']]);
		
	}
	
	private function startDefaultApplication(){
		//	TODO Access to user data an create and initialize his default application.
		
		return new mau_application($this->environment);
		
	}
	
	private function executeRequest(){
		
		switch ($this->request['action']){
			//TODO: Case the session actions (changeApp, ...)
		case 'switchApp': case 'openApp': case 'closeApp': case 'logout':
			break;
			
		default:
			$response= $this->apps[$this->currentApp]->OnAction($this->request['action'], $this->request['target'], $this->request['options']);
		}

		if ( isset( $response ) && method_exists ( $response, 'OnPaint' ) ) $response->OnPaint($this->environment); //TODO Look for some request properties, maybe they can be usefull.
		else echo "No response to action '{$this->request['action']}'";// TODO Do a page refresh. 
		
	}
	

}