<?php
class pos_pannel_display extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}

	public function OnLoad(){
		$this->class[]= 'pnl-display';
		$this->UId= $this->newUId();
		$this->call( '_displayPannel_init', array( 'mybusiness', 1, $this->rowCount, $this->colCount ) );
	}
	
	public function OnPaintContent( $document ){
		
		if ( $this->call( '_displayPannel_getContent', array( 'mybusiness', 1 ) ) ) {
			if ( $elements= $this->getResult( 'displayContent' ) ) {
				foreach($elements as $element) {
					$document->displayLabel( $element );
				}
				$elements->close();
			}
		}
	}
	
}
