<?php
class ma_ui_container extends ma_ui_widget{
	protected $content= array(); //array of widgets;
	
	public function addWidget($widget){
		$this->content[]= $widget;
	}
	
	public function paint($document){
		
		$this->OnPaint($document);
		foreach ($this->content as $widget) $widget->paint($document);
		
	}
	
	
}