<?php
class pos_sql_pos extends ma_sql_object{

	public function initialize(){
		
		// Load the procedure definitions of the class pos.

		$this->setProcedureDef('openSession', array('business', 'pos'));
		$this->setProcedureDef('getPannelContent', array('business', 'pos', 'pannel'));
		
		//
		

	}


}

