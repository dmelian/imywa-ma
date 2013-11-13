<?php
class ma_sql_object extends ma_object{
	// for objects with database access.
	
	
	protected function call( $procedure, $params=array() ){
		global $_MANAGER;
		$_MANAGER->currConnection->setCallingInfo(get_called_class());
		return $_MANAGER->currConnection->call($procedure, $params);
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