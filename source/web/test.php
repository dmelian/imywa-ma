<?php
function myErrorHandler($errno, $errstr){echo "<p>error $errno: $errstr</p>"; return false; }
function myClassLoader( $className ){
		$filePath= explode( '_', $className);
		require_once "/usr/local/ma/source/".implode('/',$filePath).'.php';
}

ini_set( 'display_errors', 'stderr' );
ini_set( 'memory_limit', -1 );
ini_set( 'max_execution_time', 40 );
error_reporting( 'E_STRICT' );
set_error_handler ( "myErrorHandler", E_ALL );
spl_autoload_register( "myClassLoader" );


echo '<P>-- BEGIN TEST --</P>';
require '/usr/local/ma/source/ma/object.php';
echo "<p>-- END TEST --</p>";