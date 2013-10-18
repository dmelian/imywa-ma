<?php
class mau_document extends ma_object{
	protected $config;
	protected $scriptLink= array();
	protected $style= array();
	protected $title;
	protected $script= array();
	
	protected $element= array();
	protected $html= array();
	protected $showServerVars= false;
	protected $widget= array();
	
	public function __construct($config){
		parent::__construct();
		$this->config= $config;
		$this->addScriptLink('http://code.jquery.com/jquery-1.10.2.js');
		$this->addScriptLink('http://code.jquery.com/ui/1.10.3/jquery-ui.js');
		$this->addScriptLink('script/ma.js');
		$this->addStyle('http://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css');
		$this->addStyle('style/ma.css');
		$this->title= 'Starting....';
	}

	public function addScriptLink( $src ) { $this->scriptLink[]= $src; }
	public function addScript( $code ) { $this->script[]= $code; }
	public function addStyle( $href ) { $this->style[]=$href; }
	
	public function addElement($element){
		$this->element[]= htmlentities($element, ENT_COMPAT, 'UTF-8');
	}
	
	public function addHtml($html){
		$this->html[]= $html;
	}
	
	public function addWidget($id, $className, $options=false){
		$this->widget[$id]= array('className'=>$className, 'options'=>$options);
	}

	private function formContent(){
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
	
	public function paint(){
		$startScript= '$.ma.manager= $("body").wdManager().data("ma-wdManager");';
		$startScript.= '$.ma.manager.loadForm(' . $this->formContent() . ');';
		$this->addScript( $startScript );
		include ('documentTpt.php');
	}
	
}