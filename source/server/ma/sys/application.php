<?php

class ma_sys_application extends ma_object{
	
	
	
	private $appDir;
	private $breadCrumb= array();
	private $stackTop= 0;
	public function __construct(){
		//TODO Initialize the application.
		
		
		
		
	}
	
	
	public function OnAction($action, $target, $options){
		$this->checkPoint("Begin __CLASS__ :: __METHOD__");
		
		switch ($action){
		case 'openForm':
			
			if (! $this->formStackIsEmpty() ) {
				$form= $this->formPop();
				if (method_exists($form, 'OnSleep')) $form->OnSleep();
				$this->formPush($form);
			}
			$formClass= strtr( $target, '/', '_' );
			if ( class_exists( $formClass ) ) {
				$form= new $formClass(); //TODO Pass the options as __construct args?
				echo $form->encode();
				$this->formPush($form);
				
			} else {
				//TODO log error: not found form.
				echo "No se encuentra el formulario '$formClass'";
			}
			
			break;
			
		case 'closeForm': case 'switchForm': case 'formCall': case 'formReturn':
			break;
			
		default:	
			echo "<p> Action on application {$this->appName}</p>";
			echo "<pre>action: $action\ntarget: $target\noptions: ".print_r($options,true)."</pre>";
			$this->log("Initiated action $action on target $target");
			$this->log($options, '', 'ActionOptions');
		}
	}
	
	
// FORM STACK
	
	private function formPush(&$form){
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
	
	
	private function updateTopForm(&$form){
		$fname = "{$this->appDir}/forms/F" . str_pad(++$this->stackTop, 4, '0', STR_PAD_LEFT);
		$sessionFile= new ma_lib_syncFile($fname);
		if ( ! $sessionFile->setContent( serialize( $form ) ) ) {
			$this->log( $this->caption( 'ERR_SERIALIZEFORM', array( 'form' => get_class( $form ) ) ), 'error' );
			
		} else {
			if (method_exists($form, "getBreadCrumbCaption")) $this->breadCrumb[ count( $this->breadCrumb ) - 1 ]= $form->getBreadCrumbCaption();
		}
		
	}

	
	public function getBreadCrumbCaptions(){
		return $this->breadCrumb;
	}
	
}

