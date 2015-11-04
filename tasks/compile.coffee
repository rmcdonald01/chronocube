beeper = require 'beeper'

gulp = require 'gulp'
plumber = require 'gulp-plumber'
mustache = require 'gulp-mustache'

cson = require 'gulp-cson'
less = require 'gulp-less'
babel = require 'gulp-babel'

embedlr = require 'gulp-embedlr'
livereload = require 'gulp-livereload'

manifest = require '../src/package.json'

[
  ['darwin64', './build/darwin64/' + manifest.productName + '.app/Contents/Resources/app']
  ['linux32', './build/linux32/opt/' + manifest.name + '/resources/app']
  ['linux64', './build/linux64/opt/' + manifest.name + '/resources/app']
  ['win32', './build/win32/resources/app']
].forEach (item) ->
  [dist, dir] = item

  # Compile menus
  gulp.task 'compile:' + dist + ':menus', ['clean:build:' + dist], ->
    gulp.src './src/menus/**/*.cson'
      .pipe plumber -> beeper()
      .pipe mustache manifest
      .pipe cson()
      .pipe gulp.dest dir + '/menus'

  # Compile styles
  gulp.task 'compile:' + dist + ':styles', ['clean:build:' + dist], ->
    gulp.src './src/css/*.css'
      .pipe plumber -> beeper()
      .pipe less()
      .pipe gulp.dest dir + '/css'
      .pipe livereload()

  # Compile scripts
  gulp.task 'compile:' + dist + ':scripts', ['clean:build:' + dist], ->
    gulp.src './src/js/*.js'
      .pipe plumber -> beeper()
      .pipe babel()
      .pipe gulp.dest dir + '/js'
      .pipe livereload()

  # Move html files
  gulp.task 'compile:' + dist + ':html', ['clean:build:' + dist], ->
    gulp.src './src/*.html'
      .pipe embedlr
        src: 'http://localhost:35729/livereload.js?snipver=1'
      .pipe gulp.dest dir + '/'
      .pipe livereload()

  # Move the node modules
  gulp.task 'compile:' + dist + ':deps', ['clean:build:' + dist], ->
    gulp.src './src/node_modules/**/*'
      .pipe gulp.dest dir + '/node_modules'
      .pipe livereload()

  # Move the images
  gulp.task 'compile:' + dist + ':img', ['clean:build:' + dist], ->
    gulp.src './src/img/*'
      .pipe gulp.dest dir + '/img'
      .pipe livereload()

  # Move the fonts
  gulp.task 'compile:' + dist + ':fonts', ['clean:build:' + dist], ->
    gulp.src './src/fonts/*'
      .pipe gulp.dest dir + '/fonts'
      .pipe livereload()

  # FONT AWESOME AND SUBFOLDERS
  gulp.task 'compile:' + dist + ':fonts2', ['clean:build:' + dist], ->
    gulp.src './src/fonts/Font-Awesome/*'
      .pipe gulp.dest dir + '/fonts/Font-Awesome'
      .pipe livereload()
  gulp.task 'compile:' + dist + ':fonts3', ['clean:build:' + dist], ->
    gulp.src './src/fonts/Font-Awesome/css/*'
      .pipe gulp.dest dir + '/fonts/Font-Awesome/css'
      .pipe livereload()
  gulp.task 'compile:' + dist + ':fonts4', ['clean:build:' + dist], ->
    gulp.src './src/fonts/Font-Awesome/less/*'
      .pipe gulp.dest dir + '/fonts/Font-Awesome/less'
      .pipe livereload()
  gulp.task 'compile:' + dist + ':fonts5', ['clean:build:' + dist], ->
    gulp.src './src/fonts/Font-Awesome/scss/*'
      .pipe gulp.dest dir + '/fonts/Font-Awesome/scss'
      .pipe livereload()
  gulp.task 'compile:' + dist + ':fonts6', ['clean:build:' + dist], ->
    gulp.src './src/fonts/Font-Awesome/fonts/*'
      .pipe gulp.dest dir + '/fonts/Font-Awesome/fonts'
      .pipe livereload()

  # Move package.json
  gulp.task 'compile:' + dist + ':package', ['clean:build:' + dist], ->
    gulp.src './src/package.json'
      .pipe gulp.dest dir

  # Compile everything
  gulp.task 'compile:' + dist, [
    'compile:' + dist + ':menus'
    'compile:' + dist + ':styles'
    'compile:' + dist + ':scripts'
    'compile:' + dist + ':html'
    'compile:' + dist + ':fonts'
    'compile:' + dist + ':fonts2'
    'compile:' + dist + ':fonts3'
    'compile:' + dist + ':fonts4'
    'compile:' + dist + ':fonts5'
    'compile:' + dist + ':fonts6'
    'compile:' + dist + ':img'
    'compile:' + dist + ':deps'
    'compile:' + dist + ':package'
  ]

# Compile for all platforms
gulp.task 'compile', [
  'compile:darwin64'
  'compile:linux32'
  'compile:linux64'
  'compile:win32'
]
