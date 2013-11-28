<?php

class ma_sys_session extends ma_object {
	
	private $environment;
	private $sessionId, $sessionDir;
	private $sequence= 0;
	private $createTime, $lastRequestTime;
	private $request; //Current request data (asoc array)
	private $user, $password, $authenticated=false;
	private $app= array();
	private $currentApp;
	private $lastUId= 0;
	private $lastReservedUId= 0;
	
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
				if ($success) $success= file_put_contents($this->sessionDir.'/lid', '0');
				if ($success) $success= chmod($this->sessionDir.'/lid', 0666);
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
	
	private function incUId($uid){
		
		//$chrs= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
		$iUId= ''; $inc= 1;
		for ($i= strlen($uid) -1; $i >= 0; $i--){
			$c= substr($uid, $i, 1);
			if ($inc) {
				$c= strtr( chr( ord($c) + $inc ), ':[{', 'Aa0');
				$inc= $c=='0' ? 1 : 0;
			}
			$iUId= $c . $iUId;
		}
		
		return $iUId;
		
	}

	public function newUId(){
		if ($this->lastUId){
			$this->lastUId= $this->incUId($this->lastUId);
			if ( $this->lastUId != $this->lastReservedUId ) return $this->lastUId;
		}
		
		$uidFile= new ma_lib_syncFile( "{$this->sessionDir}/lid" );
		if ( $uid= $uidFile->getContent( true ) ) {
			$this->incUId($uid); $uidFile->setContent( $uid );
			$this->lastUId= $uid . '0';
			$this->incUId($uid); $this->lastReservedUID= $uid . '0';
			
		} else ; //TODO: Log cannot get new uids.
		
		return $this->lastUId;
	}

	public function setGlobal( $key, $value ){ 
		$this->app[$this->currentApp]->setGlobal( $key, $value ); 
	}

	public function getGlobal( $key ){ 
		switch ( $key ){
			case 'sessionId': case 'user': return $this->$key;
			default: return $this->app[$this->currentApp]->getGlobal( $key ); 
		}
	}

	public function getGlobals(){
		$globals= $this->app[$this->currentApp]->getGlobals();
		$globals['sessionId'] = $this->sessionId;
		$globals['user']= $this->user;
		return $globals; 
	}	
	
	public function newRequest(){
		global $_MANAGER;
		
		$this->lastRequestTime= date('Y-m-d H:i:s');
		if (!$this->sessionId) {
			//TODO LOG create session error.
			exit( $this->caption('ERR_CREATESESSION') );
		}
		if (!$this->authenticated) $this->authenticate();

		
		
		
		
		if ($this->authenticated) {
			$this->extractRequestProperties();
			if (!$this->currentApp){
				
				$appClassname= $this->environment['defaultApp'];
				$app= new $appClassname($this->environment);
				// database must be accessed in the application initialization. 
				// So the host, mainDb and dbTextId must be created inside the application constructor.
				
				$this->app[$app->appName]= $app;
				$this->currentApp= $app->appName;
				$_MANAGER->currConnection= new ma_sql_connection( $app->host, $app->mainDb, $this->user, $this->password, $app->dbTextId );
				$app->initialize(); //TODO must have an uid.
				
			} else {
				$app= $this->app[$this->currentApp];
				$_MANAGER->currConnection= new ma_sql_connection( $app->host, $app->mainDb, $this->user, $this->password, $app->dbTextId );
				
			}
			
			$this->sequence++;
			$this->executeRequest();
			$_MANAGER->currConnection->close();
			
		}
		//TODO: if ($this->currentApp) $this->app[$this->currentApp]->prepareForSerialize(); // to unset the current form.
		$this->serialize();
		
	}

	private function authenticate(){
		//TODO depending on environment authMethod, authenticated the new session.
		//while the session isn't authenticated, it does not execute any request nor action.
		
		
		switch ($this->environment['authMethod']){
			
		case 'anonymous':
			$this->user= 'anonymous';
			$this->password= 'password';
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

		$this->request['options']= array_merge($_GET, $_POST);
		foreach( $this->request['options'] as $option => $value ){
			if ( substr( $option, 0, 1 ) == '_' ) {
				$option= substr( $option, 1 );
				$this->request[$option]= $this->request['options']["_$option"]; 
				unset( $this->request['options']["_$option"] );
			}
		}
		
		if ( !isset($this->request['action']) ){
			$action= substr($_SERVER['SCRIPT_NAME']
					, strrpos( $_SERVER['SCRIPT_NAME'], '/' ) + 1
					, strrpos( $_SERVER['SCRIPT_NAME'], '.' ) - strlen( $_SERVER['SCRIPT_NAME'] ) );
			$this->request['action']= ( $action && ($action != 'index') ) ? $action : 'refresh';
			
			if ( ($targetEnd= strpos($_SERVER['QUERY_STRING'], '&') ) !== false ){
				$this->request['target']= urldecode( substr( $_SERVER['QUERY_STRING'], 0, $targetEnd ));
			} else {
				$this->request['target']= urldecode( $_SERVER['QUERY_STRING'] ); 
			}
		}
		if ( !isset($this->request['source']) ) $this->request['source']= ''; //TODO: get the source.
		if ( !isset($this->request['target']) ) $this->request['target']= '';
		
	}
	
	private function executeRequest(){
		
		$app= $this->app[$this->currentApp];
		
		$config= array_merge($this->environment, $this->request);
		$responseClass= $app->mediaType . "_response";
		if ( class_exists( $responseClass ) ) $response= new $responseClass($config);
		else $response= new ma_sys_response($config); //Applications without ajax has not to define the response class.

		// Action execution
		switch ($this->request['action']){
			//TODO: Case the session actions (changeApp, ...)
		case 'switchApp': case 'openApp': case 'closeApp': case 'logout':
			break;
			
		default:
			$app->executeAction( $this->request['action']
				, $this->request['source']
				, $this->request['target']
				, $this->request['options']
				, $response
			);
		}
		
		// Paint the result in the document.
		if ( $this->request['isAjax'] ) {
			$response->paint();
			
		} else {
			$documentClass= $app->mediaType . "_document";
			$document= new $documentClass($config);
			$this->paint($document);
			$document->paint();
		}
		

	}
	
	private function paint($document){
		
		$this->app[$this->currentApp]->paint($document);
		
	}
	

}
