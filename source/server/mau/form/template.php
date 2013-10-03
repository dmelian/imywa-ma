<!doctype html>
<html lang="<?php $this->config['language']; ?>">
<head>
	<title><?php $this->title; ?></title>
	<meta charset="utf-8" />
<?php for( $i= 0; $i < count($this->scriptLink); $i++ ) {?>
	<script src="<?php echo $this->scriptLink[$i]; ?>"></script>
<?php };?>
<?php for( $i= 0; $i < count($this->style); $i++ ) {?>
	<link rel="stylesheet" href="<?php echo $this->style[$i]; ?>" />
<?php };?>
	
<script>(function($){ 
	$(function(){
	
<?php echo $this->script[0]; ?>

	});
}(jQuery));</script>

</head>

<body>
<div id="maHeader">
	<div id="maBreadCrumb"></div>
	<div id="maToolBar"></div>
</div>
<div id="maBody">
	<div id="maDashboard"></div>
	<div id="maForm"></div>
</div>
<div id="maFooter">
	<div id="maStatusBar"></div>
	<div id="maButtonBar"></div>
</div>
</body>
</html>
