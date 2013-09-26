module.exports= function(grunt){

	var configVars= {
		webDir: "/var/www/ma",
		usrDir: "/usr/local/ma"
	};
	
	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json"),
		cfg: configVars,
		
		clean: {
			options: { force: true },
			web: { src: [ "<%= cfg.webDir %>/*" ] },
			usr: { src: [ "<%= cfg.usrDir %>/*" ] },
			build: { src: [ "build/*" ] }
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
			build: { expand: true, cwd: "source/web", src: "**", dest: "build/web" }
				
		},

		replace:{
			dev: { replacements: [ 
					{ from: "%%_USRDIR_%%", to: "<%= cfg.usrDir %>" }
				],
				overwrite: true, 
				expand: true,
				src: "<%= cfg.webDir %>/*.php"
			}
		},
		
		createUsrStruct:{
			dev: { src: "<%= cfg.usrDir %>"}
		}
		

	});

	grunt.task.registerMultiTask("createUsrStruct","Create the usr Directory base structure", function(){
		grunt.file.mkdir(this.data.src + "/run", "777"  );//[, mode])
//		grunt.file.write(filepath, contents [, options])		
	});

	
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-contrib-less");
	grunt.loadNpmTasks("grunt-contrib-copy");
	grunt.loadNpmTasks("grunt-contrib-clean");
	grunt.loadNpmTasks("grunt-text-replace");

	grunt.registerTask("build", [ "clean:build", "concat:build", "less:build", "copy:build" ] ); 
	grunt.registerTask("send", [ "clean:web", "concat:dev", "less:dev", "copy:dev", "replace:dev", "createUsrStruct:dev" ] );

};
