<?php
class pos_pannel_select extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}

	public function OnLoad(){
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
					$button['onclick']= "pos_submit($action);";
					$document->button( $button );
				}
				$buttons->close();
			}
		}
	}
	
	public function OnAction( $action, $source, $target, $options){
		
		if ($source == $this->UId) {
			$this->log("This is the action '$action::$target' for the select pannel ($source).");
		}
		
	}
	
}
