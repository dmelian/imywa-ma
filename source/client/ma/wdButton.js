
var wdButton= { // extends ui-button
	
	options:{
		action: {}
	},
	
	_create: function(){
		this._super(); //$.ui.button.prototype._create.call(this);
		this.element.addClass("maButton");
		this._on({click: "action"});
	
	},
	
	_destroy: function(){
		this._off(this.element,"click");
		this.element.removeClass("maButton");
		this._super();//$.ui.button.prototype._destroy.call(this);
		
	},
	
	action: function(event){  
	//TODO: Desde aquí hay que lanzar un open formulario, que cierra el formulario actual del que este botón es parte.
		$.ma.manager.sendAction(this.options.action);
	}
	
};

$.widget("ma.wdButton", $.ui.button, wdButton);


