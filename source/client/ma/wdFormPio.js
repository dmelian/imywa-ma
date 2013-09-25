
/*	To inherit from another widget $.widget(name, [Base], prototype);	*/

var wdFormPio= { 
	options: {
	},

	_create: function(){
		this._super(); //$.ma.wdForm.prototype._create.call(this);
		this.element.addClass("pio-pio");
	},


	_destroy: function(){
		this.element.removeClass("pio-pio");
		this._super();
	}
};

$.widget("ma.wdFormPio", $.ma.wdForm, wdFormPio);


