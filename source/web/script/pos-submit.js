function pos_action( options ) {
	
	var form = document.createElement("form");
	form.setAttribute('method', 'post'); //TODO When test are passed change get to post.
	//form.setAttribute('action', 'index.php'); //Optionaly, if you want another php request entrance.
	
	for(var option in options) {
		var hidden = document.createElement("input");
		hidden.setAttribute( "type", "hidden" );
		hidden.setAttribute( "name", option );
		hidden.setAttribute( "value", options[ option ] );
		
		form.appendChild( hidden );
		form.className= 'backstage';
	}
	
	document.body.appendChild( form ); 
	form.submit();
}

function pos_buttonAction( event ){
	
	var pannel= event.parentElement;
	var options= { _action: pannel.id
		, _source: pannel.attributes.source.value
		, _target: event.value };
	pos_action( options );

}

