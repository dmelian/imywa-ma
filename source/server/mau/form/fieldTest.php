<?php
class mau_form_fieldTest extends mau_form_base{

	public function __construct(){
		parent::__construct();
		$this->widgets['myDataset']= array('className'=>'ma-wdDataset');
		$this->widgets['birthday']= array('className'=>'ma-wdDateBox', 'dataset'=>'myDataset');
		$this->widgets['momBirthday']= array('className'=>'ma-wdDateBox', 'dataset'=>'myDataset');
		$this->widgets['dadBirthday']= array('className'=>'ma-wdDateBox', 'dataset'=>'myDataset');
		
		$this->html= '<h1>Testeo de widgets</h1>';
		$this->html.= '<div id="myDataset">';
		$this->html.= 'Fecha de Nacimiento:<input id="birthday" tabindex="2"/><br/>';
		$this->html.= 'y la de su madre?:<input id="momBirthday" tabindex="1"/><br/>';
		$this->html.= 'y la de su padre?:<input id="dadBirthday" tabindex="3"/><br/>';
		$this->html.= '</div>'; //myDataset
	
	}
	
	
}