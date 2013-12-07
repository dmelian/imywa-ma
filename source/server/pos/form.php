<?php
class pos_form extends ma_sys_form{

	protected $config;

	public function OnLoad(){ //¿$response as argument or a refresh action? 

		$this->call('pos_initialize'); //business and pos are send by globals vars.
		$config= $this->getResult('posConfig');
		$this->config= $config->current();
		$config->close(); 

	}
	
	
	public function OnPaint( $document ){
		
		$document->buttonPannel('select', $this->config['selectCols'], $this->config['selectRows']);
		$document->buttonPannel('menu', $this->config['menuCols'], $this->config['menuRows']);
		$document->pannel('display');

	}
	

	public function OnAction($action, $target, $options, $response){

		switch ($action){

		case 'select': case 'menu': 
			// Execute the action
			$this->call('pos_executeAction', array($action, $target) );
			break;

		case 'loading':
			// Populating the ajax-response
			$this->call('pos_getContent');
			foreach(array('selectButtons','menuButtons','displayContent') as $content){
				$response->setContent($content, $this->getResult($content));
			}
			break;

		default:
			//$this->call( get_called_class() . "_$action", prepare_params(sessionVars, target, options));
			$this->log("pos.main.action not implemented action:'$action', target:'$target'.");

		}
	}
}
	
