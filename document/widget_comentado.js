$(function() {
	// the widget definition, where "custom" is the namespace,
	// "colorize" the widget name
	$.widget( "custom.colorize", {
		// default options
		options: {
			red: 255,
			green: 0,
			blue: 0,

			// callbacks for the triggers. see widget._trigger(type, event, data);
			change: null, 
			random: null
		},

		// the constructor
		_create: function() {
			this.element
				// add a class for theming
				.addClass( "custom-colorize" )
				// prevent double click to select text
				.disableSelection(); // Interesante este disableSelection por algo lo ponen.

			this.changer = $( "<button>", {
				text: "change",
				"class": "custom-colorize-changer"
			})
			.appendTo( this.element )
			.button(); 
			//crea el botón, lo añade a la división y lo transforma en un ui-button.
			//Se almacena en this.changer el objeto jquery asociado con este botón.

			// bind click events on the changer button to the random method
			// mas claro imposible. Al botón recien creado le asocia el metodo random
			// para que se ejecute como repuesta al click.
			this._on( this.changer, {
				// _on won't call random when widget is disabled
				click: "random"
			});
			this._refresh(); //Pone el color y lanza el _trigger (callback) "change".
								// Si el usuario no lo ha definido por defecto es null.
		},

		// called when created, and later when changing options
		_refresh: function() {
			this.element.css( "background-color", "rgb(" +
				this.options.red +"," +
				this.options.green + "," +
				this.options.blue + ")"
			);

			// trigger a callback/event
			this._trigger( "change" );
		},

		// a public method to change the color to a random value
		// can be called directly via .colorize( "random" )
		// Este metodo se llama desde el botón que se ha creado en el _create.
		random: function( event ) {
			var colors = {
				red: Math.floor( Math.random() * 256 ),
				green: Math.floor( Math.random() * 256 ),
				blue: Math.floor( Math.random() * 256 )
			};

			// trigger an event, check if it's canceled
			if ( this._trigger( "random", event, colors ) !== false ) {
				this.option( colors );
			}
		},

		// events bound via _on are removed automatically
		// revert other modifications here
		_destroy: function() {
			// remove generated elements
			this.changer.remove(); //¿ remove ? ¿ destroy ?
			// destroy. Elimina el widget asociado, pero deja el html inicial.
			// remove. Además de destruirlo, elimina el html inicial.

			this.element
				.removeClass( "custom-colorize" )
				.enableSelection()
				.css( "background-color", "transparent" );
			// lo deja todo como estaba.
		},

		// _setOptions is called with a hash of all options that are changing
		// always refresh when changing options
		_setOptions: function() {
			// _super and _superApply handle keeping the right this-context
			this._superApply( arguments );
			// entiendo que super aquí tiene el mismo resultado, porque los argumentos no varían.
			this._refresh();
			// esto se hace para llamar al refresh o update.
		},

		// _setOption is called for each individual option that is changing
		_setOption: function( key, value ) {
			// prevent invalid color values
			if ( /red|green|blue/.test(key) && (value < 0 || value > 255) ) {
				return;
			}
			this._super( key, value ); // no me queda clara la diferencia entre los dos.
			// La documentación dice que _super no lleva argumentos???
			// La documentación es un poco obtusa en esto y el código escrito peor.
			/* La diferencia es la misma que call y apply en java script
					call - llama a la funcion con una lista de variable como argumentos
						mifuncion.call(valueOfThis, arg1, arg2, arg3 ,...)
					apply - llama a la funcion con un array de valores como argumentos.
						mifuncion.call(valueOfThis, arrayOfArgs)
			*/
			// Pos la diferencia entre super y superApply es la misma.
		}
	});

	// initialize with default options
	$( "#my-widget1" ).colorize();

	// initialize with two customized options
	$( "#my-widget2" ).colorize({
		red: 60,
		blue: 60
	});

	// initialize with custom green value
	// and a random callback to allow only colors with enough green
	$( "#my-widget3" ).colorize( {
		green: 128,
		random: function( event, ui ) {
			return ui.green > 128;
		}
	});

	// click to toggle enabled/disabled
	$( "#disable" ).click(function() {
		// use the custom selector created for each widget to find all instances
		// all instances are toggled together, so we can check the state from the first
		if ( $( ":custom-colorize" ).colorize( "option", "disabled" ) ) {
			$( ":custom-colorize" ).colorize( "enable" );
		} else {
			$( ":custom-colorize" ).colorize( "disable" );
		}
	});

	// click to set options after initalization
	$( "#black" ).click( function() {
		$( ":custom-colorize" ).colorize( "option", {
			red: 0,
			green: 0,
			blue: 0
		});
	});
});

