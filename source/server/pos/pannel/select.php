<?php
class pos_pannel_select extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}

	public function OnLoad(){
		$this->class[]= 'pnl-select';
		$this->UId= $this->newUId();
		$this->call( '_selectPannel_init', array( 'mybusiness', 1, $this->rowCount * $this->colCount ) );
		$this->call( '_selectPannel_loadItem', array( 'mybusiness', 1, 'main' ) );
	}
	
	public function OnPaintContent( $document ){
		
		if ( $this->call( '_selectPannel_getButtons', array( 'mybusiness', 1 ) ) ) {
			if ( $buttons= $this->getResult( 'buttons' ) ) {
				foreach($buttons as $button) {
					$action= json_encode( array( 
						'_action' => $button['action']
						, '_target' => $button['target']
						, '_source' => $this->UId
						)
					);
					//TODO: CHANGE TYPE TO ACTION.
					if ( $button['action'] != 'nop' ) $button['onclick']= "pos_submit($action);";
					$document->button( $button );
				}
				$buttons->close();
			}
		}
	}
	
	public function OnAction( $action, $source, $target, $options){
		
		if ($source == $this->UId) {
			switch ($action){
				
			case 'group': case 'item': case 'pannelAction';
					//$this->call( get_called_class() . "_$action", prepare_params(sessionVars, target, options));
					$this->call('_selectPannel_select', array('mybusiness', 1, $target));
				break;
				
			default:
				$this->log("This is the action '$action::$target' for the select pannel ($source).");
			}
		}
		
	}
	
}
