<?php
class mau_form_ajaxResponse {
	public $responseType= 'auto';
	public $content;
	
	public function __construct($content){
		if ( is_object($content) ) $this->content= method_exists($content, "encode") ? $content->encode() : json_encode($content);
		elseif ( is_array($content) ) $this->content= json_encode($content);
		else $this->content= $content;
	}
	
	public function OnPaint($config){
		if ($config['isAjax']) {
			echo $this->content;
			
		} else {
			echo "<p>Response to ajax action. This has no html equivalent. Contact your administrator.</p>";
			echo "<pre>{$this->content}</pre>";
		}
	}
}