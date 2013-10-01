module.exports= function(grunt){

	var configVars= {
		webDir: "/var/www/ma",
		usrDir: "/usr/local/ma",
		debugDir: "../debug"
	};
	
	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json"),
		cfg: configVars,
		
		clean: {
			options: { force: true },
			dev: { src: [ "<%= cfg.webDir %>/*", "<%= cfg.usrDir %>/*" ] },
			build: { src: [ "build/*" ] },
			debug: { src: [ "<%= cfg.webDir %>/*", "<%= cfg.debugDir %>/*" ] }
		},
		
		concat: {
			options: { 
				separator: "\n",
				banner: "(function ($,undefined) {\n",
				footer: "}(jQuery));\n",
				stripBanners: true 
			},

			dev: { src: "source/client/ma/*.js", dest: "<%= cfg.webDir %>/script/ma.js" },
			build: { src: "source/client/ma/*.js", dest: "build/web/script/ma.js" }
		},

		less: { 
			dev: { src: "resource/style/*.less.css", dest: "<%= cfg.webDir %>/style/ma.css" },
			build: { src: "resource/style/*.less.css", dest: "build/web/style/ma.css" }
		},

		copy: {
			dev: { files: [
				{expand: true, cwd: "source/web", src: "**", dest: "<%= cfg.webDir %>" },
				{expand: true, cwd: "source/data", src: "**", dest: "<%= cfg.usrDir %>/data" },
				{expand: true, cwd: "source/server", src: "**", dest: "<%= cfg.usrDir %>/source" }
				]
			},
			debug: { files: [
				{expand: true, cwd: "source/web", src: "**", dest: "<%= cfg.webDir %>" },
				{expand: true, cwd: "source/data", src: "**", dest: "<%= cfg.webDir %>/usr/data" },
				{expand: true, cwd: "source/server", src: "**", dest: "<%= cfg.webDir %>/usr/source" }
				]
			},
			debugDup: { files: [
				{expand: true, cwd: "<%= cfg.webDir %>", src: "**", dest: "<%= cfg.debugDir %>" }
				]
			},
			build: { expand: true, cwd: "source/web", src: "**", dest: "build/web" }
				
		},

		replace:{
			dev: { replacements: [ 
					{ from: "%%_USRDIR_%%", to: "<%= cfg.usrDir %>" }
				],
				overwrite: true, 
				expand: true,
				src: "<%= cfg.webDir %>/*.php"
			},
			debug: { replacements: [ 
					{ from: "%%_USRDIR_%%", to: "<%= cfg.webDir %>/usr" }
				],
				overwrite: true, 
				expand: true,
				src: "<%= cfg.webDir %>/*.php"
			}
		},
		
		createUsrStruct:{
			dev: { src: "<%= cfg.usrDir %>"},
			debug: { src: "<%= cfg.webDir %>/usr"}
		}
		

	});

	grunt.task.registerMultiTask("createUsrStruct","Create the usr Directory base structure", function(){
		var fs = require('fs');
		grunt.file.mkdir( this.data.src + "/run/sessions", 0777 );
		fs.chmodSync(this.data.src + "/run/sessions", '777'); // The directory is created with 0775 mode
		grunt.file.mkdir( this.data.src + "/run/log", 0777 );
		fs.chmodSync(this.data.src + "/run/log", '777');
//		grunt.file.write(filepath, contents [, options])
	});

	
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-contrib-less");
	grunt.loadNpmTasks("grunt-contrib-copy");
	grunt.loadNpmTasks("grunt-contrib-clean");
	grunt.loadNpmTasks("grunt-text-replace");

	grunt.registerTask("build", [ "clean:build", "concat:build", "less:build", "copy:build" ] ); 
	grunt.registerTask("send", [ "clean:dev", "concat:dev", "less:dev", "copy:dev"
			, "replace:dev", "createUsrStruct:dev" ] );
	grunt.registerTask("debug", [ "clean:debug", "concat:dev", "less:dev", "copy:debug"
			, "replace:debug", "createUsrStruct:debug", "copy:debugDup" ] );

};
