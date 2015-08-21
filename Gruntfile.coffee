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

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

    # DEFINICION DE LAS TAREAS
        uglify:
            build:
                files:
                    'build/assets/libs.min.js': ['temp/libs.js']
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
    #- Coffee
        coffee:
            devel:
                files: [
                    expand: true
                    cwd: 'src/'
                    src: ['**/*.coffee']
                    dest: 'build'
                    ext: '.js'
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

    # WATCHES
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
                
    #- Concat js libs
        concat:
            options:
                separator: ';'
            libs:
                files:
                    'temp/libs.js': [
                        'bower_components/angular/angular.js',
                        'bower_components/angular-animate/angular-animate.js',
                        'bower_components/angular-aria/angular-aria.js',
                        'bower_components/angular-material/angular-material.js',
                        'bower_components/firebase/firebase.js'
                        'bower_components/angularfire/dist/angularfire.js',
                        'bower_components/angular-route/angular-route.js'
                        ]
                    'build/assets/libs.css': [
                        'bower_components/angular-material/angular-material.css'
                    ]
    #- Copy bower repo
        copy:
            devel:
                files: [
                    expand: true
                    cwd: 'bower_components/'
                    src: ['**']
                    dest: 'build/bower_components/'
                    ]
            jscript:
                files: [
                    expand: true
                    cwd: 'app/'
                    src: ['**/*.js']
                    dest: 'build'
                ]
            assets:
                files: [
                    expand: true
                    cwd: 'app/assets/'
                    src: ['**/*.*']
                    dest: 'build/assets/'
                ]

    # Conjuntos de tareas (default para lanzar grunt sin nada más)
    grunt.registerTask 'server', ['default', 'browserSync','watch']
    grunt.registerTask 'assets', ['copy:assets']
    grunt.registerTask 'default', ['newer:uglify','newer:jade','newer:sass','wiredep']

