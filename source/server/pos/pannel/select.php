<?php
class pos_pannel_select extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}
	
	public function OnPaintContent( $document ){
		global $_MANAGER;
		if ( !$this->call( '_presale_bill', array( 'kanga',1,3 ) ) ) {
			$document->output( '<p>Error: '. $this->getError() .'</p>' );
		} else {
			$document->output( '<p>Procedure executed</p>' );
		}
		
		$this->debug($_MANAGER,'manager..');
		
	}
	
	
}