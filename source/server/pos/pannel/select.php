<?php
class pos_pannel_select extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}

	public function OnLoad(){
		$this->call( '_selectPannel_init', array( 'amupark', 1, $this->rowCount * $this->colCount ) );
		$this->call( '_selectPannel_loadItem', array( 'amupark', 1, 'main' ) );
	}
	
	public function OnPaintContent( $document ){
		
		if ( $this->call( '_selectPannel_getButtons', array( 'amupark', 1 ) ) ) {
			if ( $buttons= $this->getResult( 'buttons' ) ) {
				foreach($buttons as $button) $document->button( $button );
				$buttons->close();
			}
		}
	}
	
	
}