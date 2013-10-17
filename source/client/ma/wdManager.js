var wdManager= {

	_currentForm: null,
	
	options: {
		
	},
	
	_create: function(){
		
	},
	
	_destroy: function(){
		
	},
	
	loadForm: function(formContent){
		/* formContent = {
		 * html: clean html structure
		 * className: class name of the form to be loaded
		 * widgets: array of widgets
		 * }
		 */ 
	
		if (this._currentForm) this._currentForm.destroy();
		
		if (!formContent.html) $("#maForm").text="";
		else $("#maForm").html(formContent.html);
		
		var className=  (!formContent.className) ? "ma-wdForm" : formContent.className;
		this._currentForm= $("#maForm")[className.split("-")[1]]({widgets: formContent.widgets}).data(className);
		
		//if (!!formContent.log) console.log(formContent.log);
		
	},
	
	sendAction: function(action, target, source, options){
		
		var data= typeof options == "object" ? options : {};
		data._action= action;
		data._target= target;
		data._source= source;
		
		$.ajax({ url: "index.php", type:"POST", dataType: "json", async: true
			, data: data
			, context: this
			, success: actionResponse
			, error: function(xhr, status, err){ 
				alert("...Ajax error...");
				console.log(xhr);
			}
		});
	
	},
	
	actionResponse: function(response, status, xhr){
		console.log(response); //TODO. The response is a source id and a method with its arguments.
		console.log(this);
		// var className = widgetName;
		//$( "#" + response.source )[className]( response.method, response.options );
	}
};	


$.widget("ma.wdManager", wdManager);


