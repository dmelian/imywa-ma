<?php

class pos_application extends ma_sys_application{
	
	public $appName= 'test-pos';
	public $host= 'localhost';
	public $mainDb= 'mybusiness';
	public $dbTextId= 'pos_dberror';

	public $startForm;

	public function __construct($environment){
		parent::__construct($environment);
		$plain= false;
		if ($plain) {
			$this->responseClass= 'ma_media_output';
			$this->startForm= 'pos_plainForm';
		} else {
			$this->responseClass= 'pos_response';
			$this->startForm= 'pos_form';
		}
	}
		
	public function OnLoad(){
		$this->setGlobal('business', 'mybusiness');
		$this->setGlobal('pos', 1);
		$this->setGlobal('language', 'en');
		$this->setGlobal('languages', array('en', 'es'));
		
		if ( !$this->call( 'pos_openSession' ) ){
			$this->startForm= 'pos_forceOpen';
		}
	}
	
}
