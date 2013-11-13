<?php
class pos_form_select extends pos_form{

	protected $pannel=array();
	
	public function OnLoad(){

		$this->pannel[]= new pos_pannel_select( 0, 0, 60, 100, 6, 10 );
		$this->pannel[0]->OnLoad();
		$this->pannel[]= new pos_pannel_menu( 60, 50, 40, 50 );
		$this->pannel[]= new pos_pannel_info( 60, 0, 40, 50 );
		
	}
	
	
	public function OnPaint($document){
		
		foreach ($this->pannel as $pannel) $pannel->OnPaint($document);
		
		
	}
	
	public function OnAction($action, $source, $target, $options){
		
		foreach ($this->pannel as $pannel) {
			if ( method_exists($pannel, 'OnAction') ) $pannel->OnAction($action, $source, $target, $options);
		}
		
	}
}
	
