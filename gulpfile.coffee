gulp = require 'gulp'
gulputil = require 'gulp-util'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
jade = require 'gulp-jade'

gulp.task 'lint', ->
  gulp.src(['**/*.coffee', '!gulpfile.coffee', '!node_modules{,/**}'])
  .pipe(coffeelint())
  .pipe(coffeelint.reporter())
gulp.task 'coffee', ->
  gulp.src(['**/*.coffee', '!gulpfile.coffee', '!node_modules{,/**}'])
  .pipe(coffee({bare: true}).on('error',gulputil.log))
  .pipe(gulp.dest('.'))
gulp.task 'jade', ->
  gulp.src(['**/*.jade', '!node_modules{,/**}'])
  .pipe(jade({locals:{},pretty: true}))
  .pipe(gulp.dest('./'))
gulp.task 'watch', ->
  gulp.watch '**/*.coffee',['coffee']
  gulp.watch '**/*.jade',['jade']
gulp.task 'default', ['coffee','coffee']
