<?php
class ma_ui_widget extends ma_object{
	protected $uid;
	
	public function __construct(){
		$this->uid= $this->newUId();
		
	}

	public function OnAction($action, $source, $target, $options, $response){
		
	}
	
	public function OnPaint($config){
		
	}

}