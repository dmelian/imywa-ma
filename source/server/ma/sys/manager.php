<?php
class ma_sys_manager{
	
	const ENVIRONMENT_VARS= 'dbServer,db,language,authMethod';
	const ENVIRONMENT_FILE= 'config/environment';
	const ENVIRONMENT_AUTHMETHODS= 'login,anonymous,http';
	
	public $usrDir, $webDir;
	
	// Environment
	public $dbServer= 'localhost';
	public $db= 'mia';
	public $language= 'en';
	
	private $session;
	private $texts;
	private $initialized;
	
	

	public function __construct(){

		// PHP Initialization

		ini_set( 'display_errors', 'stderr' );
		ini_set( 'memory_limit', -1 );
		ini_set( 'max_execution_time', 40 );
		error_reporting( 'E_STRICT' );
		set_error_handler ( "ma_sys_manager::phpErrorHandler", E_ALL );
		spl_autoload_register( "ma_sys_manager::phpClassLoader" );

		// MA initialization

		$this->initialized= false;
		$this->usrDir= substr(__FILE__, 0, -strlen("/source/ma/sys/manager.php"));
		$this->webDir= substr($_SERVER['SCRIPT_FILENAME'], 0, strrpos($_SERVER['SCRIPT_FILENAME'],'/'));
		
		$envFilename= $this->usrDir . '/' . self::ENVIRONMENT_FILE;
		if (file_exists($envFilename)){
			foreach(file($envFilename, FILE_IGNORE_NEW_LINES) as $envLine){
				list($property,$value)= explode('=',$envLine);
				$this[$property]= $value;
			}
			$this->initialized= true;
		}
		
		require_once($this->usrDir . "/source/ma/sys/texts.php");
		$this->texts= new ma_sys_texts();
	}


	
// STATIC FUNCTIONS.
	
	public static function phpErrorHandler( $errno, $errstr, $errfile, $errline, $errcontext ){
		global $_MANAGER;
		echo "Error $errno: $errstr";
		//TODO: Logs the error and set error count. If is an warning continue, else return true or die.
		return true;
	}

	
	public static function phpClassLoader( $className ){
		global $_MANAGER;
		
		$classModule= ($last_= strrpos($className,'_')) > 0 ? substr($className, 0, $last_): '';
		if (isset($_MANAGER->texts)) {
			$_MANAGER->texts->loadFile($classModule, $_MANAGER->getSourceFilename($classModule)."/texts.{$_MANAGER->language}");
		}
		require_once $_MANAGER->getSourceFilename($className).'.php';
	}
	

	
	
// METHODS.	
	
	public function getSourceFilename($id){
		$filePath= explode('_',$id);
		return "{$this->usrDir}/source/".implode('/',$filePath);
	}
	
	
	public function newRequest(){
		echo "<p>New Request received ....</p>";
		if ($this->initialized) echo "<p>System Initialized</p>"; else echo "<p>Warning: the system is not initialized.</p>"; 
		
		
		$sessionId= isset(	$_COOKIE['SESSION_ID']	) ?  $_COOKIE['SESSION_ID'] : '';
		if(	$isAjax= isset(	 $_SERVER['HTTP_X_REQUESTED_WITH'] ) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
			$ajaxCaller= isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
		}
		
		
		
	}
}
