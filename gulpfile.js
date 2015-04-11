/*global require */
var gulp = require('gulp');
var jade = require('gulp-jade');
var wrap = require('gulp-wrap-amd');

gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('templates', function(){
  gulp.src('./src_front/app/templates/**/*.jade')
    .pipe(jade({client: true, pretty: true}))
    .pipe(wrap({deps: ['jade'], params: ['jade']}))
    .pipe(gulp.dest('./public/javascripts/app/templates/'));
});
