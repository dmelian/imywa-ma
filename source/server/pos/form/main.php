<?php
class pos_form_main extends pos_form{

	protected $pannel=array();
	
	public function OnLoad(){

		$this->pannel[]= new pos_pannel_select( 0, 25, 75, 80, 2, 4 );
		$this->pannel[0]->OnLoad();
		$this->pannel[]= new pos_pannel_menu( 0, 0, 75, 25, 2, 4 );
		$this->pannel[1]->OnLoad();
		$this->pannel[]= new pos_pannel_display( 75, 0, 25, 100, 3, 10 );
		$this->pannel[2]->OnLoad();
		
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
	
