<?php
class pos_submit_document extends ma_object{
	
	protected $buffer= array();
	
	public function paint(){
		echo '<html><head>';
		echo '<link rel="stylesheet" href="style/pos.css">';
		echo '<script type="text/javascript" src="script/pos-submit.js"></script>';
		echo '</head><body>';
		echo implode($this->buffer);
		echo '<body></html>';
	}
	
	public function output( $out ){ $this->buffer[]= $out; }
	
	public function button( $button ){
		
		$content= $button['caption'];

		$this->buffer[]= "<button class=\"{$button['class']}\" value=\"{$button['id']}\""
			. " onclick=\"" . htmlentities($button['onclick']) . "\""
			.">$content</button>";
		
	}

	public function displayLabel ( $label ) {

	}

}
