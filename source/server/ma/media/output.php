<?php
class ma_media_output extends ma_object{

	public $documentClass= 'ma_media_output';
	public $title;

	protected $style= array();
	protected $script= array();
	protected $buffer= array();
	
	public function paint(){

		echo '<!doctype html>';
		echo "<html lang=\"{$this->config['language']}\">";
		echo '<head>';
		echo "<title>{$this->title}</title>";
		echo '<meta charset="utf-8" />';
		for( $i= 0; $i < count($this->style); $i++ ) {
			echo "<link rel=\"stylesheet\" href=\"{$this->style[$i]}\" />";
		}
		for( $i= 0; $i < count($this->script); $i++ ) {
			echo "<script src=\"{$this->script[$i]}\"></script>";
		}
		echo '</head><body>';
		echo implode($this->buffer);
		echo '<body></html>';
	}
	
	public function write( $out ){ $this->buffer[]= $out; }
	public function addScript( $src ) { $this->script[]= $src; }
	public function addStyle( $href ) { $this->style[]=$href; }
	
}
