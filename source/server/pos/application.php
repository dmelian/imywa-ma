<?php

class pos_application extends ma_sys_application{
	
	public $appName= 'kpark';
	public $mediaType= 'pos';
	public $startForm= 'pos_form_select';
	public $host= 'localhost';
	public $mainDb= 'kangaroos';
	public $dbTextId= 'pos_dberror';
	
}