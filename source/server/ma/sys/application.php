<?php

class ma_sys_application extends ma_object{
	
	public $mediaType, $appName, $startForm;
	
	protected $currentForm;
	protected $breadCrumb= array();
	
	private $appDir;
	private $stackTop= 0;
	
	public function __construct($environment){
		//TODO Initialize the application.
		$this->appDir= "{$environment['sessionDir']}/{$this->appName}";
		$success= mkdir($this->appDir."/forms", 0777, true);
		if ($success) $success= chmod($this->appDir, 0777);
		if ($success) $success= chmod($this->appDir."/forms", 0777);
		//TODO IF not success then log error and die. 
		
		//TODO Load the Start form. ??
		
	}
	
	public function initialize(){
		
		$formClass= $this->startForm;
		$form= new $formClass();
		if ( method_exists($form, 'initialize') ) $form->initialize();
		$this->formPush($form);
		
	}
	
	public function executeAction($action, $source, $target, $options, $response){
		
		//TODO: Check the source.
		//TODO: Call OnAction($action, $options, $response);
		
		switch ($action){
		case 'openForm':
			
			$formClass= trim(strtr( $target, '/', '_' ),"_ \t\n");
			if ( class_exists( $formClass ) ) {
				$this->currentForm= new $formClass();
				$this->currentForm->OnOpen($options, $response);
//				initialize and OnRefresh are reemplaced for OnOpen. Too much simple.
//				$this->currentForm->initialize( $options );
//				$this->currentForm->executeAction( 'refresh', $source, $target, $options, $response);
				$this->formPush($this->currentForm);
				
			} else {
				//TODO log error: not found form.
				echo "No se encuentra el formulario '$formClass'";
				//TODO return errorResponse object.
			}
			break;
			
		case 'closeForm': case 'switchForm': case 'formCall': case 'formReturn':
			break;
			
		default:
			$this->currentForm= $this->formPop();
			$response= $this->currentForm->executeAction($action, $source, $target, $options, $response);
			$this->formPush($this->currentForm);
			return $response;
			
		}
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
		$sessionFile= new ma_lib_syncFile($fname);
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
				$formFile= new ma_lib_syncFile("$this->appDir/forms/F$fname");
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
			$formFile= new ma_lib_syncFile("$this->appDir/forms/F$fname");
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
		$sessionFile= new ma_lib_syncFile($fname);
		if ( ! $sessionFile->setContent( serialize( $form ) ) ) {
			$this->log( $this->caption( 'ERR_SERIALIZEFORM', array( 'form' => get_class( $form ) ) ), 'error' );
			
		} else {
			if (method_exists($form, "getBreadCrumbCaption")) $this->breadCrumb[ count( $this->breadCrumb ) - 1 ]= $form->getBreadCrumbCaption();
		}
		
	}
	
}

