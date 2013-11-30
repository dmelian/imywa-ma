<?php
class pos_pannel_menu extends pos_pannel{

	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}

	public function OnLoad(){
		$this->class[]= 'pnl-menu';
		$this->UId= $this->newUId();
		$this->call( '_menuPannel_init', array( 'mybusiness', 1, $this->rowCount, $this->colCount ) );
		$this->call( '_menuPannel_loadMenu', array( 'mybusiness', 1, 'SELECT' ) );
	}
	
	public function OnPaintContent( $document ){
		
		if ( $this->call( '_menuPannel_getButtons', array( 'mybusiness', 1 ) ) ) {
			if ( $buttons= $this->getResult( 'buttons' ) ) {
				foreach($buttons as $button) {
					$action= json_encode( array( 
						'_action' => $button['action']
						, '_target' => $button['target']
						, '_source' => $this->UId
						)
					);
					if ( $button['action'] != 'nop' ) $button['onclick']= "pos_action($action);";
					$document->button( $button );
				}
				$buttons->close();
			}
		}
	}
	
	public function OnAction( $action, $source, $target, $options){
		
		if ($source == $this->UId) {
			$this->call('_menuPannel_select', array('mybusiness', 1, $target));
		}
		
	}
	
}
