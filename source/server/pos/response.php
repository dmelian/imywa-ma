<?php
class pos_response extends ma_object{

	public $documentClass= 'pos_document';

	protected $content=array();

	public function paint(){
		echo '{';
		$sep0= '';
		foreach( $this->content as $id => $content ){
			echo "$sep0\"$id\":[";
			$sep1= '';
			foreach( $content as $rec ){
				echo $sep1 . json_encode( $rec );
				$sep1= ',';
			}
			echo ']';
			$sep0= ',';
		}
		echo '}';
	}

	public function setContent($id, $content, $source, $optionIds= array()){
		$this->content[$id]= $content;
	}

}
