var wdForm= {

	options: {
		widgets: {}
	},

	_create: function(){
		this.element.addClass("maForm-testing");
		this.activateWidgets();
		this._update();
	},
	
	
	_destroy: function(){
		this.deactivateWidgets();
		this.element.removeClass("maForm-testing");
	},

	_setOption: function(option, value){
		this._update();
	},


	_update: function(){
	},
	
	activateWidgets: function(){
		for (var id in this.options.widgets){
			
			var widget= this.options.widgets[id];
			widget.object= $("#"+id)[widget.className.split("-")[1]]()
				.data(widget.className);
			
			if (widget.options !== undefined){
				for (var option in widget.options){
					widget.object._setOption(option, widget.options[option]);
				}
			}
			
			widget.object._setOption("validate", this.onWidgetValidate);
		}
	},
	
	deactivateWidgets: function(){
		for (var id in this.options.widgets) this.options.widgets[id].object.destroy();
	},
	
	onWidgetValidate: function( event, ui ){
		console.log('Form->Widget-Validate....');
		//TODO: Where is the record?, and the field information?
		var actions={};
		actions.action= 'validateField';
		$.ajax({ url: "index.php?" + form, type:"POST", dataType: "json", async: false
			, data: actions
			, success: function(result, status, xhr){ formContent= result;	}
			, error: function(xhr, status, err){ alert("...Ajax error..."); }
		});

		
		
	}
	
	

}; 

$.widget("ma.wdForm", wdForm);


