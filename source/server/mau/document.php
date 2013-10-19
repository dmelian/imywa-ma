<?php
class mau_document extends mau_media {
	protected $config;
	protected $scriptLink= array();
	protected $style= array();
	protected $title;
	protected $script= array();
	
	public function __construct($config){
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
	
	
	public function paint(){
		$startScript= '$.ma.manager= $("body").wdManager().data("ma-wdManager");';
		$startScript.= '$.ma.manager.loadForm(' . $this->formContent() . ');';
		$this->addScript( $startScript );
		include ('documentTpt.php');
	}
	
}