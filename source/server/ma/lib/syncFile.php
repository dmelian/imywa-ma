<?php
class ma_lib_syncFile {

	public $errorno;
	public $content;
	public $filename;

	public function __construct($filename){
		$this->filename= $filename;
	}

	public function getContent(){

		if (file_exists($this->filename)) {
			if ($file= fopen($this->filename,'r')){

				$count = 0;
				while ((!$lock = flock($file,LOCK_EX)) && $count < 10){
					usleep(50000); $count++;
				}

				if ($lock) {

					fseek($file,0); $this->content= fread($file, filesize($this->filename));
					flock($file,LOCK_UN); fclose($file);
					return true;
						
				} else $this->errorno = "LOCKFILEERROR";
			} else $this->errorno= "OPENFILEERROR";
		} else $this->errorno = "FILENOTFOUND";
			
		return false;
	}


	function setContent($content){

		$newfile= !file_exists($this->filename);
		if ($file= fopen($this->filename,'c+')){

			$count = 0;
			while ((!$lock = flock($file,LOCK_EX)) && $count < 10){
				usleep(50000); $count++;
			}
				
			if ($lock) {
					
				fseek($file,0); fwrite($file, $content);
				flock($file,LOCK_UN); fclose($file);
				if ($newfile) chmod($this->filename, 0666);
				return true;

			} else $this->errorno = "LOCKFILEERROR";
		} else $this->errorno = "CREATEFILEERROR";

		return false;
	}

}
