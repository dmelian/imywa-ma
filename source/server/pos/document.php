<?php
class pos_document extends ma_object{
	
	protected $buffer= array();
	
	public function paint( $response ){
		echo '<html><head>';
		echo '<link rel="stylesheet" href="style/pos.css">';
		echo '<script type="text/javascript" src="script/pos-ajax.js"></script>';
		echo '</head><body>';
		echo implode($this->buffer);
		echo '<script type="text/javascript">';
		echo 'pos_update("' . $response->paint() . '");';
		echo '</script>';
		echo '<body></html>';
	}
	
	public function output( $out ){ $this->buffer[]= $out; }
	
	public function button( $button ){
		
		$this->buffer[]= "<button class=\"{$button['class']}\" id=\"{$button['id']}\">"
			. "{$button['caption']}</button>";

		//Dynamically we load the value and onclickevent.
		
	}

	public function buttonPannel( $id, $colCount, $rowCount ){
		$this->output( "<div class=\"pannel pnl-$id\" config='cols:$colCount,rows:$rowCount'>" );

		for ( $ix= 0, $row= 0; $row < $rowCount; $row++ ) {
			for ( $col= 0; $col < $colCount; $col++, $ix++ ) {
				$this->button( array('id'=>"$id$ix", 'caption'=>'--'
					, 'class'=>"disabled row$row col$col") );
			}
		}

		$this->output( "</div>" ); 

	}

	public function pannel($id){
		$this->output( "<div class=\"pannel pnl-$id\"></div>" );
	}

}
