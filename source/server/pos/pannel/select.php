<?php
class pos_pannel_select extends pos_pannel{
	protected $rowCount, $colCount;
	
	public function __construct( $x, $y, $width, $height, $rowCount, $colCount ){
		
		parent::__construct( $x, $y, $width, $height );
		$this->rowCount= $rowCount;
		$this->colCount= $colCount;
		
	}
	
	public function OnPaintContent( $document ){
		//if ( $this->conn->call('pos', 'getItemButtons') ){
			
		//}
	}
	
	
}