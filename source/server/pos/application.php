<?php

class pos_application extends ma_sys_application{
	
	public $appName= 'test-pos';
	public $mediaType= 'pos';
	public $startForm= 'pos_form';
	public $host= 'localhost';
	public $mainDb= 'mybusiness';
	public $dbTextId= 'pos_dberror';
		
	public function OnLoad(){
		$this->setGlobal('business', 'mybusiness');
		$this->setGlobal('pos', 1);
		$this->setGlobal('language', 'en');
		$this->setGlobal('languages', array('en', 'es'));
		
		if ( !$this->call( 'pos_openSession', array($this->business, $this->pos) ) ){
			$this->startForm= 'pos_forceOpen';
		}
	}
	
}
