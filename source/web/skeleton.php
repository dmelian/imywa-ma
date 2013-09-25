<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />

	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script src="script/ma.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" />
	<link rel="stylesheet" href="style/ma.css" />
	
<script>(function($){
		
	$(function(){
		
		$.ma.manager= $("body").wdManager().data("ma-wdManager");
		$.ma.manager.openForm("sys/start", {setFilter:"Jua*", storeData: true, record:{id: 123, name: "Domingo"
			, address: { address: "C/Cebrián 42", postalCode: "35002", county: "Las Palmas de Gran Canaria"}}});
		
	});
		
}(jQuery));</script>

	<title>IMYWA - START</title>
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
