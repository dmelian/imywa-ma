var wdManager= {

	_currentForm: null,
	
	options: {
		
	},
	
	_create: function(){
		
	},
	
	_destroy: function(){
		
	},
	
	execAction: function(action){
		switch (action.action){
		case "openForm": 
			this.openForm(action.form, action.arguments);
			break;
		default:
			this.sendAction(action.action, action);
		}
	},
	
	openForm: function(form, actions){
	
		// 1. SEND THE OPEN FORM REQUEST.
		var formContent={};
		if (!actions) actions={};
		actions.action= 'openForm';
		$.ajax({ url: "execAction.php?" + form, type:"POST", dataType: "json", async: false
			, data: actions
			, success: function(result, status, xhr){ formContent= result;	}
			, error: function(xhr, status, err){ alert("...Ajax error..."); }
		});
		
		// TODO: unsuccessfull request. 
		
		// 2 . DESTROY THE OLD-CURRENT FORM
		if (this._currentForm) this._currentForm.destroy();
		
		// 3 . SWITCH THE OLDER HTML CONTENT WITH THE CONTENT OBTAINED ON STEP 1
		if (!formContent.html) $("#maForm").text="";
		else $("#maForm").html(formContent.html);
		
		// 4 .  ACTIVATE THE NEW-CURRENT FORM.
		var className=  (!formContent.className) ? "ma-wdForm" : formContent.className;
		this._currentForm= $("#maForm")[className.split("-")[1]]({widgets: formContent.widgets}).data(className);
		
		if (!!formContent.log) console.log(formContent.log);
	},
	
	sendAction: function(action, args){
		var actionResponse={command: "close"};
		var actions=args;
		actions.action= action;
		$.ajax({ url: "execAction.php?" + action, type:"POST", dataType: "json", async: false
			, data: actions
			, success: function(result, status, xhr){ actionResponse= result;	}
			, error: function(xhr, status, err){ alert("...Ajax error..."); }
		});
	
		// TODO: unsuccessfull request. 
	
		this.execActionResponse(actionResponse);
	},
	
	execActionResponse: function(actionResponse){
		switch (actionResponse.command){
		case "openLocation": 
			window.location = actionResponse.location;
			break;
		}
	}
};	


$.widget("ma.wdManager", wdManager);


