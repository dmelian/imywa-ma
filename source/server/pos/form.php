<?php
class pos_form extends ma_sys_form{

	protected $config;

	public function OnLoad(){ //¿$response as argument or a refresh action? 

		$this->call('pos_initialize'); //business and pos are send by globals vars.
		$config= $this->getResult('posConfig');
		$this->config= $config->current();
		$config->close(); 

	}
	
	public function OnRefresh( $response ){

		$this->call('pos_getContent');
		foreach(array('select','menu','display') as $content){
			$response->setContent($content, $this->getResult($content));
			//TODO UId, TARGET AND OPTIONS
		}
	}
	
	public function OnPaint( $document ){
		
		$document->buttonPannel('select', $this->config['selectCols'], $this->config['selectRows'], $this->UId);
		$document->buttonPannel('menu', $this->config['menuCols'], $this->config['menuRows'], $this->UId);
		$document->pannel('display');

	}
	
	public function OnAction($action, $target, $options){

		switch ($action){

		case 'select': case 'menu': 
			$this->call('pos_executeAction', array($action, $target) );
			return true;


		default:
			//$this->call( get_called_class() . "_$action", prepare_params(sessionVars, target, options));
			$this->log("pos.main.action not implemented action:'$action', target:'$target'.");
			return false;

		}
	}
}
	
