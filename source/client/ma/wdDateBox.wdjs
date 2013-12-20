var wdDateBox = {
		
	options: {
		id: '',
		data: '',
			
		//callbacks
		validate: null
		
	},
	
	_create: function() {
		this.element.addClass( "maDateBox" );
		this._on( { focus: "onUnformat" } ); this._on( { blur: "onValidate" } );
		this._on( { keydown: "onKeydown" } );

	},
	
	_destroy: function() {
		this._off( this.element,"keydown" );
		this._off( this.element,"focus" ); this._off( this.element,"blur" );
		this.element.removeClass( "maDateBox" );
		
	},
	
	/* The data is unformat before edit it */
	onUnformat: function( event ) {
		//TODO: Access to the container record field data and formating it for editing.
		
	},
	
	/* The data is formated when it is showing to the user. */
	onFormat: function( event ) {
		//TODO: Access to the container record field data and formating it for showing.
	},
	
	/* After edit, the data is valitated by the server */
	onValidate: function( event ) {
		this._trigger( 'validate' ); 
	},

	onKeydown: function( event ) {
		switch( event.keyCode ) {
		case $.ui.keyCode.TAB:
			//event.preventDefault();
			break;
		}
	}

	
	
};

$.widget( "ma.wdDateBox", wdDateBox );


