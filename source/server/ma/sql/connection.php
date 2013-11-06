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
	
	public function __construct($host, $database, $user, $password, $textId){
		parent::__construct();
		$this->loadTexts($textId); //TODO: suport multi database with theirs textids.
		
		$this->config= array( 'host' => $host, 'database' => $database, 'user' => $user, 'textId' => $textId );
		$this->conn= mysqli_init();
		if (!$this->conn){ 
			$this->ErrorNo= 'ESYS'; 
			$this->errorMessage= $this->caption('mysqliError'); 
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
			case 2005:	$errorId= 'unknownHost'; break; // connect_errno: 2005 - Unknown MySQL server host ...
			case 1044: 
			case 1045:	$errorId= 'accessDenied'; break; // connect_errno: 1044 y 1045 - Access denied for user ...
			case 1049:	$errorId= 'unknownDatabase'; break; // connect_errno: 1049 - User authenticated but database not found ...
			default: 	$errorId= 'dbGenericError'; //Any other error
		}
		$params= array_merge( $this->config, array( 'errno' => $this->conn->errno, 'errmsg' => $this->conn->error) );
		$this->errorMessage= $this->caption( $errorId, $params );
		
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

	protected function finishTransaction(){
		if ($this->closed) return;
		if ($this->unfinishedTransaction){
			if ($this->success) $this->commit();
			else $this->rollback();
			$this->unfinishedTransaction= false;
		}
	}
	
	public function close(){
		if ($this->closed) return;
		$this->finishTransaction();
		$this->conn->close();
		$this->closed= true;
	}

	public function __destruct(){
		$this->close();
	}
	
	public function call($procedure, $params=array()){
		
		if ( $this->closed ) return;
		$this->closeResults();
		
		if ( $this->success ){
			if( !$this->conn->real_query( 'set @errorno = null' ) ); //TODO: log this error.
			$query= "call $procedure" . $this->expand( $params );
			//TODO: $_LOG->log("PROC> {$this->host}:{$this->database}:{$_SESSION->user} $query");
			$this->success= $this->conn->real_query( $query );
			if ( $this->success ){
				$this->unfinishedTransaction= true;
				
				// retrieve the posible results.
				unset( $this->results ); $this->results= array();
				while ( $this->conn->more_results() ){
					$this->results[]= new ma_sql_resultIterator( $this->conn->store_result() );
					$this->conn->next_result();
				}
				
				// named the retrieved results and look for an error.
				unset( $this->resultIds );
				for( $result=0; $result < count($this->results); $result++ ){
					$firstRow= $this->results[$result]->current();
					if ( isset( $firstRow['resultId'] ) ) {
						$this->resultIds[$firstRow['resultId']]= $result;
					}
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
				}

			} else {
				// Manage mysql errors.
				
				//TODO: $_LOG->log("Error en la llamada a store procedure");
				$this->setError();
			}
		}
		return $this->success; 
	}

	
	public function query($query){
		global $_SESSION;
		global $_LOG;
		
		if ($this->closed) return;
		$this->closeResults();
		
		$sucess=false;
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
	
	
	public function getResult($resultId){
		if (isset($this->resultIds[$resultId])) return $this->results[$this->resultIds[$resultId]]; 
		else return array();
	}
	
	public function closeResults(){
		if (isset($this->results)){
			foreach($this->results as $result) $result->close();
			unset($this->results);
		}
	}

	protected function expand($userParams, $defParams=false){
		
		$parlist = ''; $prefix = '';
		if (! $userParams) $userParams = array();
		elseif (!is_array($userParams)) $userParams = explode(',',$userParams);
		
		if ($defParams){
			// The procedure's parameters have been defined		
			if ($defParams != 'void') foreach($defParams as $defParam) {
				if (isset($userParams[$defParam])) $parlist.= "$prefix\"{$userParam[$defParam]}\"";
				else $parlist.= $prefix . 'null';
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
