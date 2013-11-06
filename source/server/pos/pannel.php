<?php
class pos_pannel extends ma_sql_object{
	protected $x, $y, $width, $height;
	
	public function __construct($x, $y, $width, $height){
		
		parent::__construct();
		$this->x= $x; $this->y = $y;
		$this->width= $width; $this->height= $height;
		
	}
	
	public function OnPaint( $document ){
		
		$position= "left: {$this->x}%; top: {$this->y}%; width:{$this->width}%; height:{$this->height}%;";
		$document->output( "<div class=\"pannel\" style=\"$position\">" );
		if ( method_exists( $this, 'OnPaintContent' ) ) $this->OnPaintContent( $document );
		$document->output( "</div>" ); 
		
	}
	
	
	
}