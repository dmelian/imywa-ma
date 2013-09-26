<?php
class ma_sys_manager{
	
//	const ENVIRONMENT_ATTRIBUTES= 'host,db,language,authMethod';
	const ENVIRONMENT_FILE= 'data/environment';
//	const ENVIRONMENT_AUTHMETHODS= 'login,anonymous,http';
	
	public $environment;
	public $texts;
	

	public function __construct(){

		// PHP Initialization

		ini_set( 'display_errors', 'stdout' );
		ini_set( 'memory_limit', -1 );
		ini_set( 'max_execution_time', 40 );
		error_reporting( 'E_STRICT' );
		set_error_handler ( "ma_sys_manager::phpErrorHandler", E_ALL );
		spl_autoload_register( "ma_sys_manager::phpClassLoader" );

		// MA initialization

		$this->environment= array();
		$this->environment['usrDir']= substr(__FILE__, 0, -strlen("/source/ma/sys/manager.php"));
		$this->environment['webDir']= substr($_SERVER['SCRIPT_FILENAME'], 0, strrpos($_SERVER['SCRIPT_FILENAME'],'/'));
		
		$envFilename= $this->environment['usrDir'] . '/' . self::ENVIRONMENT_FILE;
		if (file_exists($envFilename)){
			foreach(file($envFilename, FILE_IGNORE_NEW_LINES) as $envLine){
				list($property,$value)= explode('=',$envLine);
				$this->environment[trim($property)]= trim($value);
			}
		}
		
		require_once($this->environment['usrDir'] . "/source/ma/sys/texts.php");
		$this->texts= new ma_sys_texts();
	}


	
// STATIC FUNCTIONS.
	
	public static function phpErrorHandler( $errno, $errstr, $errfile, $errline, $errcontext ){
		global $_MANAGER;
		echo "<p>Error $errno: $errstr on file $errfile at line $errline</p>";
		//TODO: Logs the error and set error count. If is an warning continue, else return true or die.
		return true;
	}

	
	public static function phpClassLoader( $className ){
		global $_MANAGER;
		
		$filePath= explode( '_', $className);
		require_once "{$_MANAGER->environment['usrDir']}/source/".implode('/',$filePath).'.php';
	}
	

	
	
// METHODS.	
	
	
	public function newRequest(){
		$session= ma_sys_session::create($this->environment);
		$session->OnNewRequest();
		
	}
}
