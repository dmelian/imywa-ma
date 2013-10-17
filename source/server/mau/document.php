<?php
class mau_document extends ma_object{
	protected $config;
	protected $scriptLink= array();
	protected $style= array();
	protected $title;
	protected $script= array();
	
	protected $element= array();
	
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

	public function paint(){
		for ($e=0; $e<count($this->element); $e++) echo "<p>{$this->element[$e]}</p>";
		echo '<pre>' . print_r($_SERVER, true) . '</pre>';
		return;
		$this->addScript('$.ma.manager= $("body").wdManager().data("ma-wdManager")'); // $.ma.manager.loadForm('.$formContent.');');
		include ('form/template.php');
	}
	
}