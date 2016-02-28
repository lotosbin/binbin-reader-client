gulp = require 'gulp'
gulputil = require 'gulp-util'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
jade = require 'gulp-jade'
gulp.task 'node_modules',->
  return gulp.src('./node_modules/**/*.*')
  .pipe(gulp.dest('./dist/node_modules/'))
gulp.task 'package',->
  return gulp.src('./src/package.json')
  .pipe(gulp.dest('./dist/'))
gulp.task 'copy', ->
  return gulp.src('bower_components/**/*.*')
  .pipe(gulp.dest('./dist/bower_components'))
gulp.task 'lint', ->
  gulp.src(['./src/**/*.coffee', '!gulpfile.coffee', '!node_modules{,/**}'])
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())
gulp.task 'coffee', ->
  gulp.src(['./src/**/*.coffee', '!gulpfile.coffee', '!node_modules{,/**}'])
  .pipe(coffee({bare: true}).on('error',gulputil.log))
  .pipe(gulp.dest('./dist/'))
gulp.task 'jade', ->
  gulp.src(['./src/**/*.jade', '!node_modules{,/**}'])
  .pipe(jade({locals:{},pretty: true}))
  .pipe(gulp.dest('./dist/'))
gulp.task 'watch', ->
  gulp.watch '**/*.coffee',['coffee','copy']
  gulp.watch '**/*.jade',['jade']
gulp.task 'default', ['package','copy','node_modules','coffee','jade']
