var gulp=require('gulp');
var minifycss=require('gulp-minify-css');
var concat=require('gulp-concat');
var uglify=require('gulp-uglify');
var rename=require('gulp-rename');
var jshint=require('gulp-jshint');
var rev=require('gulp-rev');

gulp.task("jshint",function(){
  return gulp.src("js/*.js")
    .pipe(jshint())
    .pipe(jshint.reporter('default'))
})

gulp.task('minifycss', function() {
  return gulp.src('css/*.css')    //需要操作的文件
    .pipe(rename({suffix: '.min'}))   //rename压缩后的文件名
    .pipe(minifycss())   //执行压缩
    .pipe(gulp.dest('Css'));   //输出文件夹
});

gulp.task('minifyjs', function() {
  return gulp.src('js/*.js')      //需要操作的文件
    .pipe(concat('main.js'))    //合并所有js到main.js
    .pipe(gulp.dest('js'))       //输出到文件夹
    .pipe(rename({suffix: '.min'}))   //rename压缩后的文件名
    .pipe(uglify())    //压缩
    .pipe(gulp.dest('Js'));  //输出
});

gulp.task('default',['jshint'],function() {
  gulp.start('minifycss','minifyjs');
});