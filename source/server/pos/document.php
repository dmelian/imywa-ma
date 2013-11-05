<?php
class pos_document extends ma_object{
	
	protected $buffer= array();
	
	public function paint(){
		echo '<html><head>';
		echo '<link rel="stylesheet" href="style/pos.css">';
		echo '</head><body>';
		echo implode($this->buffer);
		echo '<body></html>';
	}
	
	public function output( $out ){ $this->buffer[]= $out; }

}