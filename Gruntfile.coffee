module.exports = (grunt) ->

    # Carga de plugins
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-browser-sync'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-wiredep'
    grunt.loadNpmTasks 'grunt-newer'
    grunt.loadNpmTasks 'grunt-usemin'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-filerev'

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

    #- BrowserSync
        browserSync:
            bsFiles:
                src: 'app/**/*'
            options:
                server:
                    baseDir: "app/"
                ui:
                    port: 8080
                open: false
                notify: false
                watchTask: true
    #- wiredep
        wiredep:
            task:
                src: ['app/index.html']
                
    #- Jade
        jade:
            devel:
                options:
                    pretty: true
                files: [
                    expand: true
                    cwd: 'app/'
                    src: ['**/*.jade']
                    dest: 'app'
                    ext: '.html'
                    extDot: 'first'
                    ]
    #- Sass
        sass:
            devel:
                files: [
                    expand: true
                    cwd: 'app/styles/'
                    src: ['*.sass']
                    dest: 'app/styles/'
                    ext: '.css'
                    extDot: 'first'
                    ]

    #- WATCHES
        watch:
            options:
                spawn: false
            jade:
                files: "app/**/*.jade"
                tasks: ['jade']
            coffee:
                files: "app/**/*.coffee"
                tasks: ['coffee']
            sass:
                files: "app/css/*.sass"
                tasks: ['sass']
            less:
                files: "app/css/*.less"
                tasks: ['less']
            js:
                files: "app/**/*.js"
                tasks: ['copy:jscript']           
            bower:
                files: "bower.json"
                tasks: ['wiredep']
   #- USEMIN:: Concat, minify y filerevision de js y css en index.html
        copy:
            build:
                src: 'app/index.html'
                dest: 'build/index.html'
        filerev:
            options:
                encoding: 'utf8'
                algorithm: 'md5'
                length: 20
            source:
                files: [
                    src: [
                        'build/js/*.js',
                        'build/css/*.css'
                        ]
                    ]
        useminPrepare:
            html: 'app/index.html'
            options:
                dest: 'build'
        usemin:
            html: 'build/index.html'
            options:
                assetsDirs: ['build','build/css', 'build/js','css','js']
      
    # Conjuntos de tareas (default para lanzar grunt sin nada más)
    grunt.registerTask 'server', ['default', 'browserSync','watch']
    grunt.registerTask 'assets', ['copy:assets']
    grunt.registerTask 'build',[
        'copy:build', 'useminPrepare','concat','uglify','cssmin','filerev','usemin'
    ]
    grunt.registerTask 'default', ['newer:jade','newer:sass','wiredep']

