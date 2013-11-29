<?php

class ma_sql_connection extends ma_object{
	// It is no possible to extends form mysqli, because of you can not declare class attributes on the child class
	public $success= false;
	public $errorNo;
	public $errorMessage;
	
	protected $config;
	protected $conn; //The mysqli connection
	protected $results; //results of a procedure call or a query.
	protected $resultIds; //The identifiers of the nonanonymous results
	
	protected $closed= true;
	protected $unfinishedTransaction= false;
	protected $callingClass='';
	
	public function __construct($host, $database, $user, $password, $textId){
		parent::__construct();
		$this->loadTexts($textId); //TODO: suport multi database with theirs textids.
		
		$this->config= array( 'host' => $host, 'database' => $database, 'user' => $user, 'textId' => $textId );
		$this->conn= mysqli_init();
		if (!$this->conn){ 
			$this->ErrorNo= 'ESQL00'; 
			$this->errorMessage= $this->caption("ma_sql_error_{$this->errorNo}"); 
			return; 
		}
		if ($this->conn->real_connect( $host, $user, $password, $database ) ) {
			$this->conn->autocommit(false);
			$this->conn->set_charset('utf8');
			$this->success= true;
			$this->closed= false;
			
		} else $this->setError();
	}

	protected function setError(){
		switch($this->conn->errno){
			case 2005:	$this->errorNo= 'ESQL01'; break; // connect_errno: 2005 - Unknown MySQL server host ...
			case 1044: 
			case 1045:	$this->errorNo= 'ESQL02'; break; // connect_errno: 1044 y 1045 - Access denied for user ...
			case 1049:	$this->errorNo= 'ESQL03'; break; // connect_errno: 1049 - User authenticated but database not found ...
			default: 	$this->errorNo= 'ESQL04'; //Any other error
		}
		$params= array_merge( $this->config, array( 'errno' => $this->conn->errno, 'errmsg' => $this->conn->error) );
		$this->errorMessage= $this->caption( "ma_sql_error_{$this->errorNo}", $params, false );
		
	}
	
	public function setCallingInfo($class){
		$this->callingClass= $class;
	}
	
	protected function logError($errorType, $query){
		$this->log("$errorType {$this->errorNo}",'sql.error');
		$this->log("\tCLASS: {$this->callingClass}", 'sql.error');
		$this->log("\tPROC: $query",'sql.error');
		$this->log("\tERR: {$this->errorNo} - {$this->errorMessage}",'sql.error');
	}

	public function commit(){
		if ($this->closed) return;
		if ($this->unfinishedTransaction) {
			$this->conn->commit(); 
			$this->unfinishedTransaction= false;
		}
	}
	
	public function rollback(){
		if ($this->closed) return;
		if ($this->unfinishedTransaction) {
			$this->conn->rollback(); 
			$this->unfinishedTransaction= false;
		}
	}

	public function beginTransaction(){
		if ($this->closed) return;
		if ($this->unfinishedTransaction) {
			$this->errorNo = 'ESQL05';
			$this->errorMessage= $this->caption( "ma_sql_error_{$this->errorNo}" );
			$this->success= false;
			$this->close();
		} else $this->unfinishedTransaction= true;
		return $this->unfinishedTransaction;
	}
	
	public function endTransaction(){
		if ($this->closed) return;
		if ($this->unfinishedTransaction){
			if ($this->success) $this->commit();
			else $this->rollback();
			$this->unfinishedTransaction= false;
		}
	}
	
	public function close(){
		if ($this->closed) return;
		$this->endTransaction();
		$this->conn->close();
		$this->closed= true;
	}

	public function __destruct(){
		$this->close();
	}
	
	private function globalsQuery(){
		$sentence= '';
		foreach ($this->getGlobals() as $global => $value){
			if ( is_scalar($value) ) $sentence.= ", @$global='$value'";
			elseif ( is_array($value) ) for ($i= 0; $i < count($value); $i++) $sentence.= ", @$global$i='{$value[$i]}'";
		}
		return "set @errorno= null$sentence;";
	}
	
	public function call($procedure, $params=array(), $paramDefs=false ){
		
		if ( $this->closed ) return;
		$this->closeResults();
		
		if ( !$this->unfinishedTransaction || $this->success ){
			if( !$this->conn->real_query( $this->globalsQuery() ) ); //TODO: log this error.
			$query= "call $procedure" . $this->expand( $params, $paramDefs );
			$this->log("PROC> {$this->config['host']}:{$this->config['database']}:{$this->config['user']} $query", 'sql');
			$this->success= $this->conn->real_query( $query );
			if ( $this->success ){
				// retrieve the posible results.
				unset( $this->results ); $this->results= array();
				while ( $this->conn->more_results() ){
					$this->results[]= new ma_sql_resultIterator( $this->conn->store_result() );
					$this->conn->next_result();
				}
				
				// named the retrieved results and look for an error.
				unset( $this->resultIds ); $this->resultIds= array();
				for( $result=0; $result < count($this->results); $result++ ){
					$firstRow= $this->results[$result]->current();
					if ( isset( $firstRow['resultId'] ) ) {
						$this->resultIds[$firstRow['resultId']]= $result;
					}
					//TODO error if the result has no rows and you cannot read the resultId.
				}
				
				/* Manage application errors
				 * 
				 * If an error ocurrs the session var @errorno has the error number 
				 * and the result 'ma_error' the error asociated info. 
				 */
				if ( !$this->conn->real_query( 'select @errorno as errorno' ) ); //TODO: log this error
				$errRslt= $this->conn->use_result(); $errRow= $errRslt->fetch_assoc(); $errRslt->free();
				$this->success = is_null( $errRow['errorno'] ); 
				if ( !$this->success ){
					$this->errorNo= $errRow['errorno'];
					$this->errorMessage= $this->caption(
						"{$this->config['textId']}_$this->errorNo"
						, $this->getResult('ma_error')->current()
						, false
					);
					$this->logError('APP-ERROR', $query);
				}
				
				if ( !$this->unfinishedTransaction ) {
					if ( $this->success ) $this->conn->commit(); else $this->conn->rollback();
				}

			} else {
				// Manage mysql errors.
				
				$this->setError();
				$this->logError('SQL-ERROR', $query);
				
				if ( !$this->unfinishedTransaction ) $this->conn->rollback();
			}
		}
		return $this->success; 
	}

	
/*	public function query($query){
		global $_SESSION;
		global $_LOG;
		
		if ($this->closed) return;
		$this->closeResults();
		
		$success=false;
		if ($this->success){
			$success= $this->conn->real_query($query);
			if ($success){
				unset($this->results); $this->results= array();
				$this->results[]= new bas_sqlx_resultIterator($this->conn->store_result());
				unset($this->resultIds);
				$this->resultIds= array('last_query'=> 0);

			} else {
				$_LOG->log("Error: en la query <<$query>>");
				$this->setError();
			}
		}
		return $success; 
	}
*/
	
	public function getResult($resultId){
		if (isset($this->resultIds[$resultId])) return $this->results[$this->resultIds[$resultId]]; 
		else return array(); //TODO return a signal that the result is not found.
	}
	
	public function closeResults(){
		if (isset($this->results)){
			foreach($this->results as $result) $result->close();
			unset($this->results);
		}
	}

	protected function expand($userParams, $paramDefs=false){
		
		$parlist = ''; $prefix = '';
		if (! $userParams) $userParams = array();
		elseif ( !is_array( $userParams ) ) $userParams = explode(',',$userParams);
		
		if ($paramDefs){
			// defined params. A string array with the parameter names. 
			// Parameter array can be defined as array(name, count).
			if ($paramDefs != 'void') foreach($paramDefs as $defParam) {
				if ( is_array( $defParam ) ){
					for( $i=0; $i<$defParam[1]; $i++ ) {
						if ( isset($userParams["{$defParam[0]}$i"]) ) {
							$parlist.= "$prefix\"" . $userParam["{$defParam[0]}$i"] . "\"";
						} else $parlist.= $prefix . 'null';
						$prefix= ', ';
					}
				} else {
					if (isset($userParams[$defParam])) $parlist.= "$prefix\"{$userParam[$defParam]}\"";
					else $parlist.= $prefix . 'null';
				}
				$prefix= ', ';
			}
			
		} else {
			foreach($userParams as $userParam) {
				if (strlen($userParam)==0 or is_null($userParam)) $parlist.= $prefix . 'null';  
				else $parlist.= "$prefix\"$userParam\""; 
				$prefix= ', '; 
			}
		}
		return "($parlist)";
	}
	
	
}
?>
