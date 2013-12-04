<?php
class pos_response extends ma_object{

	protected $content=array();

	public function paint(){
		foreach($this->content as $id => $content){
			echo "content:$id\n";
			foreach($content as $element) {
				print_r( $element );
			}
		}
	}

	public function setContent($id, $content){
		$this->content[$id]= $content;
	}

}
