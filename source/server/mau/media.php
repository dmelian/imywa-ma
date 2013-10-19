<?php
class mau_media {
	
	protected $element= array();
	protected $html= array();
	protected $showServerVars= false;
	protected $widget= array();
	
	public function addElement($element){
		$this->element[]= htmlentities($element, ENT_COMPAT, 'UTF-8');
	}
	
	public function addHtml($html){
		$this->html[]= $html;
	}
	
	public function addWidget($id, $className, $options=false){
		$this->widget[$id]= array('className'=>$className, 'options'=>$options);
	}
	
	protected function formContent(){
		$form= array();
	
		$form['className']='ma-wdForm';
	
		// html
		$form['html']= '';
		for ( $e= 0; $e < count($this->html); $e++ ) $form['html'].= $this->html[$e];
		for ( $e= 0; $e < count($this->element); $e++ ) $form['html'].= "<p>{$this->element[$e]}</p>";
		if ( $this->showServerVars ) $form['html'].= '<pre>' . print_r($_SERVER, true) . '</pre>';
	
		// widgets
		$form['widgets']= $this->widget;
		//foreach ( $this->widget as $id => $widget ) $form['widget'][$id]= $widget;
	
		return json_encode($form);
	
	}
	
}