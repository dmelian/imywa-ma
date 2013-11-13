<?php

class pos_application extends ma_sys_application{
	
	public $appName= 'test-pos';
	public $mediaType= 'pos';
	public $startForm= 'pos_form_select';
	public $host= 'localhost';
	public $mainDb= 'mybusiness';
	public $dbTextId= 'pos_dberror';
	
	public $business, $pos;
	
	public function OnLoad(){
		$this->business= 'mybusiness';
		$this->pos= 1;
		
		if ( !$this->call( 'pos_openSession', array($this->business, $this->pos) ) ){
			$this->startForm= 'pos_dialog_forceOpen';
		}
	}
	
}
