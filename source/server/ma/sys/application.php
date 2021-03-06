<?php

class ma_sys_application extends ma_sql_object{
	
	/* Application attributes that derived clases must define
	public $mediaType
	public $appName
	public $startForm;
	public $host
	public $mainDb
	public $dbTextId
	*/
	public $UId;
	protected $currentForm;
	protected $breadCrumb= array();
	protected $globals= array();
	protected $responseClass;
	
	private $appDir;
	private $stackTop= 0;
	
	public function __construct($environment){
		parent::__construct();

		$this->UId= $this->newUId();
		$this->responseClass= $environment['responseClass'];

		$this->appDir= "{$environment['sessionDir']}/{$this->appName}";
		$success= mkdir($this->appDir."/forms", 0777, true);
		if ($success) $success= chmod($this->appDir, 0777);
		if ($success) $success= chmod($this->appDir."/forms", 0777);
		//TODO IF not success then log error and die. 
		
	}
	
	
	public function setGlobal($key, $value){ $this->globals[$key]= $value; }
	public function getGlobal($key) { return $this->globals[$key]; } 
	public function getGlobals(){ return $this->globals; }
	
	public function executeAction( $action, $source, $target, $options, &$response ){

		$responseClass= $this->responseClass;
		$response= new $responseClass();
		
		if ($source == $this->UId) switch ($action){

			case 'init':
				if ( method_exists( $this, 'OnLoad' ) ) $this->OnLoad();
		
				$formClass= $this->startForm;
				$this->currentForm= new $formClass();
				$this->currentForm->executeAction($action, $this->currentForm->UId, $target, $options, $response);
				$this->formPush($this->currentForm);
				return true;

			case 'refresh':
				$source=$this->topForm()->UId; 
				break;

			case 'openForm':
			case 'closeForm': case 'switchForm': case 'formCall': case 'formReturn':
				$this->log("ERROR. Application action '{$this->appName}':'$action' not implemented.");
				return true;
						
			default:
				if ( method_exists($this, 'OnAction') ) {
					return $this->OnAction( $action, $target, $options );
				} else {
					$this->log("ERROR. Application action '{$this->appName}':'$action' not designed.");
					return false;
				}

		}
			
		$this->currentForm= $this->formPop();
		$catched= $this->currentForm->executeAction($action, $source, $target, $options, $response);
		$this->formPush($this->currentForm);
		return $catched;

	}
	
	public function paint($document){
		if ( method_exists($this, 'OnPaint') ) $this->OnPaint($document);
		if ( isset($this->currentForm) ) $this->currentForm->paint($document);
	}

	
	public function getBreadCrumbCaptions(){
		return $this->breadCrumb;
	}
	
// FORM STACK
	
	private function formPush($form){
		$caption= method_exists($form, "getBreadCrumbCaption")? $form->getBreadCrumbCaption() : '?';
		array_push($this->breadCrumb, $caption);
		$fname = "{$this->appDir}/forms/F" . str_pad(++$this->stackTop, 4, '0', STR_PAD_LEFT);
		$sessionFile= new ma_sys_syncFile($fname);
		if ( ! $sessionFile->setContent( serialize( $form ) ) ) {
			$this->log( $this->caption( 'ERR_SERIALIZEFORM', array( 'form' => get_class( $form ) ) ), 'error' );
		}
	
	}
	
	private function formPop($jump=1){
		//TODO: El último formulario de la pila no puede sacar. O si se saca se muestra el diagolo fin de la aplicación.
		$form= false;
		while ($jump > 0 && $this->stackTop > 0) {
			$fname = str_pad($this->stackTop--, 4, '0', STR_PAD_LEFT);
			if (--$jump == 0) {
				$formFile= new ma_sys_syncFile("$this->appDir/forms/F$fname");
				if ($formFile->getContent()) $form= unserialize($formFile->content);
				else $this->log($this->caption( 'ERR_UNSERIALIZEFORM' ), 'error' );
			}
			//unlink ("$this->appDir/forms/F$fname"); //TODO: problems with ajax parallels requests.
			array_pop($this->breadCrumb);
		}
		if ($form) return $form;
	}
	
	/*TODO: FORMSEQUENCENO
	 Al ser las llamadas ajax masivamente paralelas, no se pude seguir un número de secuencia.
	Vamos a poner un número de secuencia de formulario, para correguir los posibles errores de formulario.
	Si el número de formulario no es el mismo que se viene en el POST, muestro el formulario y no hago caso
	a la acción.
	*/
	
	private function topForm(){
	
		if ($this->stackTop > 0) {
			$fname = str_pad($this->stackTop, 4, '0', STR_PAD_LEFT);
			$formFile= new ma_sys_syncFile("$this->appDir/forms/F$fname");
			if ($formFile->getContent()) $form= unserialize($formFile->content);
			else $this->log($this->caption( 'ERR_UNSERIALIZEFORM' ), 'error' );
			return $form;
		}
	}
	
	private function formStackIsEmpty(){
		return $this->stackTop == 0;
	}
	
	
	private function updateTopForm($form){
		$fname = "{$this->appDir}/forms/F" . str_pad(++$this->stackTop, 4, '0', STR_PAD_LEFT);
		$sessionFile= new ma_sys_syncFile($fname);
		if ( ! $sessionFile->setContent( serialize( $form ) ) ) {
			$this->log( $this->caption( 'ERR_SERIALIZEFORM', array( 'form' => get_class( $form ) ) ), 'error' );
			
		} else {
			if (method_exists($form, "getBreadCrumbCaption")) $this->breadCrumb[ count( $this->breadCrumb ) - 1 ]= $form->getBreadCrumbCaption();
		}
		
	}
	
}

