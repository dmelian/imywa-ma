function pos_action( options ) {

	//Send the action And execute the response on the ajax way.
    var query = [];
    for (var key in options) {
        query.push(encodeURIComponent(key) + '=' + encodeURIComponent(options[key]));
    }

	var xhr= new XMLHttpRequest();
	xhr.open("post", "index.php", false);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
	xhr.send(query.join('&'));

	//Do something with the xhr.responseText;
	alert(xhr.responseText);


	
}
