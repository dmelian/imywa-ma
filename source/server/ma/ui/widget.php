<?php
interface ma_ui_widget{

	public function OnAction($action, $target, $options, &$response);
	public function OnPaint($config);

}