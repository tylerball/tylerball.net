var gulp = require('gulp');
var sass = require('gulp-sass')

gulp.task('sass', function () {
  return gulp.src('./source/stylesheets/**/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./.tmp/dist/stylesheets'));
});

gulp.task('watch', function () {
  gulp.start('sass')
  gulp.watch('./source/**/*.scss', ['sass']);
});

gulp.task('default', function () {
  gulp.start('sass')
});
