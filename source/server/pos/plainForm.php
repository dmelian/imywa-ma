<?php
class pos_plainForm extends ma_sys_form{

	protected $config;

	public function OnLoad(){ //¿$response as argument or a refresh action? 

		$this->call('pos_initialize'); //business and pos are send by globals vars.
		$config= $this->getResult('posConfig');
		$this->config= $config->current();
		$config->close(); 

	}
	
	public function OnPaint( $document ){
		$this->call('pos_getContent');
		$document->addStyle('style/pos.css');
		$document->addScript('script/pos-submit.js');
		foreach(array('select','menu','display') as $contentId){
			$document->write( "<div id=\"$contentId\" class=\"pannel pnl-$contentId\" source=\"{$this->UId}\">" );
			if ($elements= $this->getResult( $contentId ) ) {
				foreach($elements as $element) {
					$document->write( "<button class=\"{$element['class']}\" value=\"{$element['id']}\"" );
					if ( $element['action'] != 'nop' ) $document->write( " onclick=\"pos_buttonAction(this)\"" );
					$document->write( ">{$element['caption']}</button>" );
				}
				$elements->close();
			}
			$document->write( '</div>' );
		}

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

