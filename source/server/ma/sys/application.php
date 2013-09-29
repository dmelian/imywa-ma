<?php

class ma_sys_application extends ma_object{
	
	private $appDir;
	private $breadCrumb= array();
	private $stackTop= 0;
	
	
	public function OnAction($action, $target, $options){
		echo "<p> Action on application {$this->appName}</p>";
		echo "<pre>action: $action\ntarget: $target\noptions: ".print_r($options,true)."</pre>";
		$this->log("Initiated action $action on target $target");
		$this->log($options, '', 'ActionOptions');
	}

	
	
	// ----------------------------------------------------
	// The Stack
	
	public function formpush(&$form){
		$caption= method_exists($form, "getBreadCrumbCaption")? $form->getBreadCrumbCaption() : '?';
		array_push($this->breadCrumb, $caption);
		$fname = "{$this->appDir}/forms/F" . str_pad(++$this->stacktop, 4, '0', STR_PAD_LEFT);
		$sessionFile= new ma_lib_syncFile($fname);
		if ( ! $sessionFile->setContent( serialize( $form ) ) ) {
			$this->log( $this->caption( 'ERR_SERIALIZEFORM', array( 'form' => get_class( $form ) ) ), 'error' );
		}
	
	}
	
	public function formpop($jump=1){
		global $_LOG;
		//TODO: El último formulario de la pila no puede sacar. O si se saca se muestra el diagolo fin de la aplicación.
		$form= false;
		while ($jump > 0 && $this->stacktop > 0) {
			$fname = str_pad($this->stacktop--, 4, '0', STR_PAD_LEFT);
			if (--$jump == 0) {
				$formFile= new syncFile("$this->appDir/forms/F$fname");
				if ($formFile->getContent()) $form= unserialize($formFile->content);
				else $_LOG->log("Error: No se ha podido obtener el formulario de la pila.");
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
	
	public function topform(){
	
		if ($this->stacktop > 0) {
			$fname = str_pad($this->stacktop, 4, '0', STR_PAD_LEFT);
			$formFile= new syncFile("$this->appDir/forms/F$fname");
			if ($formFile->getContent()) $form= unserialize($formFile->content);
			else $_LOG->log("Error: No se ha podido obtener el formulario del top de la pila.");
			return $form;
		}
	}
	
	public function formstackisempty(){
		return $this->stacktop == 0;
	}
	
	
	public function updatetopform(&$form){
		global $CONFIG;
		$fname = "$this->sessiondir/forms/F" . str_pad($this->stacktop, 4, '0', STR_PAD_LEFT);
		$fp = fopen($fname,'w');
		fwrite($fp, serialize($form));
		fclose($fp);
		chmod($fname, 0666);
	
	}
	
	public function getBreadCrumbCaptions(){
		return $this->breadCrumb;
	}
	
	
	
}

