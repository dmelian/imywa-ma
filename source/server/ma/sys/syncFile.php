<?php
class ma_sys_syncFile {

	public $errorno;
	public $content;
	public $filename;
	
	private $file= 0;
	private $locked= false;

	public function __construct($filename){
		$this->filename= $filename;
	}

	
	public function getContent($lock= false){

		if ($this->locked) {
			flock($this->file,LOCK_UN); 
			fclose($this->file);
			$this->locked= false;
		}
		
		if (file_exists($this->filename)) {
			if ($this->file= fopen($this->filename,'r')){

				$count = 0;
				while ((!$locked = flock($this->file,LOCK_EX)) && $count < 10){
					usleep(50000); $count++;
				}

				if ($locked) {

					fseek($this->file,0); $this->content= fread($this->file, filesize($this->filename));
					if ($lock) {
						$this->locked= true;
					} else {
						flock($this->file,LOCK_UN); fclose($this->file);
						$this->locked= false; 
					}
					return true;
						
				} else $this->errorno = "LOCKFILEERROR";
			} else $this->errorno= "OPENFILEERROR";
		} else $this->errorno = "FILENOTFOUND";
			
		return false;
	}


	function setContent($content){

		$newfile= !file_exists($this->filename);
		$locked= $this->locked;
		if (!$this->locked) {
			if ($this->file= fopen($this->filename,'c+')){
	
				$count = 0;
				while ((!$locked = flock($this->file,LOCK_EX)) && $count < 10){
					usleep(50000); $count++;
				}
			} else {
				$this->errorno = "CREATEFILEERROR";
				return false;
			}
		}
					
		if ($locked) {
			fseek($this->file,0); fwrite($this->file, $content);
			flock($this->file,LOCK_UN); fclose($this->file);
			if ($newfile) chmod($this->filename, 0666);
			$this->locked= false;
			return true;
	
		} else $this->errorno = "LOCKFILEERROR";

		return false;
	}

}
