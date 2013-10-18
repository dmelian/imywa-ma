<?php
interface ma_ui_widget{

	public function OnAction($action, $source, $target, $options, $response);
	public function OnPaint($config);

}