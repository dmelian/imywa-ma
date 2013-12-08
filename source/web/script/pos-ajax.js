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

	pos_update(xhr.responseText);
	
}

function pos_buttonAction( event ){
	
	var pannel= event.parentElement;
	var options= { _action: pannel.id
		, _source: pannel.attributes.source.value
		, _target: event.value };
	pos_action( options );

}

function pos_update( content ){
	var parsedContent= JSON.parse(content);
	for (var pannelId in parsedContent) {
		var pannel= parsedContent[pannelId];
		for (var i=0; i<pannel.length; i++){
			var elementName= pannelId.concat(i);
			var button= document.getElementById(elementName);
			button.innerHTML= pannel[i].caption;
			button.className= pannel[i].class;
			button.value= pannel[i].target;
		}
	}
}
