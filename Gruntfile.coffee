
module.exports = (grunt) ->
  webpackOptions = require("./webpack.config.coffee")
  grunt.initConfig
    less:
      compile:
        options: {}
        files:
          "public/stylesheets/main.css": "websrc/less/main.less"
    "http-server":
      dev:
        root: "public/"
        port: 3000
    webpack:
      compile:
        webpackOptions
    watch:
      less:
        files: ["websrc/less/*.less"]
        tasks: ["less"]
        options:
          spawn: false
      express:
        files:  [ "index.coffee", "routes/*.coffee", "models/*.coffee", "socket/*.coffee" ]
        tasks:  [ "express:dev" ]
        options:
          spawn: false
      livereload:
        options:
          livereload: true
        files: ['public/**/*']

  grunt.loadNpmTasks 'grunt-webpack'
  grunt.loadNpmTasks "grunt-http-server"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.registerTask "default", ["less", "webpack", "http-server", "watch"]
