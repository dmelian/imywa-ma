<?php
class ma_sql_object extends ma_object{
	// for objects with database access.
	protected $procDef= array();

	protected function setProcedureDef( $procedure, $paramDef= 'void' ){
		$this->procDef[$procedure]= $paramDef;
	/* paramDef

		parameter definitions.
		Is an string array of parameter names.
		It is posible to send an array of parameters. In these cases the definition is not an string, but an array of the name and count.
		
		example 
			setProcedureDef ( 'openDay', array( 'year', 'month', 'day', array('cash', 3))).
		
		Then the call must be 
			call('openDay', array('year'=>2013, 'month'=>10, 'day'=>12, 'cash0'=>1000, 'cash1'=>0, 'cash2'=>500));
		or 
			call('openDay', array('year'=>2013, 'month'=>10, 'day'=>12, 'cash'=>array(1000, 0, 500));

		Improvements:
			parameter direction (in | out | inout)
			set or temporary tables parameters.
			output querys definitions.

	*/
	}
	
	protected function call( $procedure, $param=array(), $paramDef=false ){
		global $_MANAGER;
		if ( !$paramDef && isset( $this->procDef[$procedure] ) ) $paramDef= $this->procDef['procedure'];
		$_MANAGER->currConnection->setCallingInfo(get_called_class()); //TODO: improve this error log.
		return $_MANAGER->currConnection->call($procedure, $param, $paramDef);
	}
	
	protected function getError() {
		global $_MANAGER;
		return $_MANAGER->currConnection->errorMessage;
	}
	
	protected function getResult($resultId){
		global $_MANAGER;
		return $_MANAGER->currConnection->getResult($resultId);
	}
	
	protected function beginTransaction(){
		global $_MANAGER;
		return $_MANAGER->currConnection->beginTransaction();
	}
	
	protected function endTransaction(){
		global $_MANAGER;
		return $_MANAGER->currConnection->endTransaction();
	}
}
