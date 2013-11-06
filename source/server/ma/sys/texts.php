<?php
class ma_sys_texts{
	
	private $captions= array();
	private $descriptions= array();
	private $fileIds= array();
	private $lastId= '', $lastParams= '';
	
	public function getCaption($id, $params){
		$this->lastId= $id; $this->lastParams= $params;
		$caption= isset( $this->captions[$id] ) ? addslashes($this->captions[$id]) : "TEXT[$id] undefined";
		if (is_array($params)){
			extract($params, EXTR_PREFIX_ALL,'');
			eval ("\$caption = \"$caption\";");
		}
		return $caption;
	}
	
	public function getDescription($id, $params){
		$description= isset($this->descriptions[$id])?addslashes($this->descriptions[$id]):'';
		if (is_array($params)){
			extract($params, EXTR_PREFIX_ALL,'');
			eval ("\$description = \"$description\";");
		}
		return $description;
	}
	

	public function getLastIdDescription(){ return $this->getDescription($this->lastId, $this->lastParams); }
	
/*
	Each line of the file has the format:		<id> <caption> :: <description>
	You can coment a line with a # as first line character
	You can add section with a line like: 		[ <sectionId> ]
*/
	public function loadFile($fileId, $filename){
		
		if(!isset($this->fileIds[$fileId]) && file_exists($filename)) {
			$f= fopen($filename,'r');
			$section= $fileId;
			while(!feof($f)){
				$textLine= trim(fgets($f));
				if ((strlen($textLine) > 0) && (substr($textLine,0,1) != '#')){
					if ((substr($textLine,0,1) == '[') && (substr($textLine,-1) == ']')) {
						$section= ($fileId ? "{$fileId}_":'').trim(substr($textLine,1,-1));
					} else {
						if ($caption= strpbrk($textLine," \t")){
							$text_id= trim(substr($textLine,0,strlen($textLine)-strlen($caption)));
							$caption= trim($caption);
							if (($sep= strpos($caption, '::')) !== false){
								$description= trim(substr($caption,$sep+2));
								$caption= trim(substr($caption,0,$sep));
							} else $description= '';
							$ext_text_id= ($section ? "{$section}_":'').$text_id;
							$this->captions[$ext_text_id]= $caption;
							if ($description) {
								$this->descriptions[$ext_text_id]= $description;
							}
						}
					}
				}
			} 
			fclose($f);
			$this->fileIds[$fileId]= 1;
		}
	}
		
}