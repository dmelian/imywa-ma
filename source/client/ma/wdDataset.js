var wdDataset = {

	options: {
		id: '',
		initialized: false,

	},

	_create: function() {
		this.element.addClass( "maDataset" );

		var actions={};
		actions.action= 'getDataDef';
		$.ajax({ url: "index.php?", type:"POST", dataType: "json", async: false
			, data: actions
			, success: function(result, status, xhr){ 
				this._init(result);
			}
			, error: function(xhr, status, err){ alert("...Ajax error..."); }
		});

	},

	_destroy: function() {
		this.element.removeClass( "maDataset" );

	},
	
	_init: function( dataDefs ){
		alert("initilizing the dataset");
		console.log( dataDefs );
	}

};

$.widget( "ma.wdDataset", wdDataset );
