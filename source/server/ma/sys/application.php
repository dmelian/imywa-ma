<?php

class ma_sys_application {
	
	public function OnAction($action, $target, $options){
		echo "<p> Action on application {$this->appName}</p>";
		echo "<pre>action: $action\ntarget: $target\noptions: ".print_r($options,true)."</pre>";
	}
	
	
}

