<?php
class pos_main extends pos_form{

	public function OnLoad(){

		$this->call('pos_initialize'); //business and pos are send by globals vars.

	}
	
	
	public function OnPaint($document){
		
		if ( $this->call( 'pos_getContent' ) ) {

			$document->output( '<div class="pannel pnl-select">' );
			if ( $selectButtons= $this->getResult( 'selectButtons' ) ) {

				foreach($selectButtons as $button) {
					$action= json_encode( array( 
						'_action' => $button['action']
						, '_target' => $button['target']
						, '_source' => $this->UId
						)
					);
					if ( $button['action'] != 'nop' ) $button['onclick']= "pos_action($action);";
					$document->button( $button );
				}
				$selectButtons->close();
			}
			$document->output( "</div>" ); 


			$document->output( '<div class="pannel pnl-menu">' );
			if ( $menuButtons= $this->getResult( 'menuButtons' ) ) {
				foreach($menuButtons as $button) {
					$action= json_encode( array( 
						'_action' => $button['action']
						, '_target' => $button['target']
						, '_source' => $this->UId
						)
					);
					if ( $button['action'] != 'nop' ) $button['onclick']= "pos_action($action);";
					$document->button( $button );
				}
				$menuButtons->close();
			}
			$document->output( "</div>" ); 

			$document->output( '<div class="pannel pnl-display">' );
			if ( $elements= $this->getResult( 'displayContent' ) ) {
				foreach($elements as $element) {
					$document->displayLabel( $element );
				}
				$elements->close();
			}
			$document->output( "</div>" ); 

		}		
	}
	
	public function OnAction($action, $target, $options, $response){

		switch ($action){

		case 'group': case 'item': 
				$this->call('pos_executeAction', array($action, $target) );

/*		case 'pannelAction';
				//$this->call( get_called_class() . "_$action", prepare_params(sessionVars, target, options));
				$this->call('_selectPannel_select', array('mybusiness', 1, $target));
			break;
			$this->call('_menuPannel_select', array('mybusiness', 1, $target));

*/			
		default:
			//$this->call( get_called_class() . "_$action", prepare_params(sessionVars, target, options));
			$this->log("This is the action '$action::$target'.");

		}
	}
}
	
