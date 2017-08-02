/*
 * gulp
 * devDependencies included in package.json
 * npm install to get started
 */

// Load plugins
var gulp = require('gulp'),
	sass = require('gulp-sass'),
	autoprefixer = require('gulp-autoprefixer'),
	cssnano = require('gulp-cssnano'),
	plumber = require('gulp-plumber'),
	sourcemaps = require('gulp-sourcemaps'),
	//uglify = require('gulp-uglify'),
	rename = require('gulp-rename'),
	//concat = require('gulp-concat'),
	notify = require('gulp-notify'),
	del = require('del'),
	livereload = require('gulp-livereload'),
	http = require('http');

// Styles
gulp.task('styles', function() {
	return gulp.src([
		'Sass/global.scss'
	])
	.pipe(plumber({
		errorHandler: function (err) {
			console.log(err);
			notify.onError({
				message: 'Error in styles task: <%= error.message %>',
				sound: false
			})(err);
			this.emit('end');
		}
	}))
	.pipe(sourcemaps.init())
	.pipe(sass())
	.pipe(gulp.dest('css'))
	.pipe(rename({ suffix: '.min' }))
	//.pipe(uglify())
	.pipe(cssnano({ zindex: false, reduceIdents: false }))
	.pipe(autoprefixer('last 2 version'))
	.pipe(gulp.dest('css'))
	.pipe(sourcemaps.write('.'))
	.pipe(gulp.dest('css'))
	.pipe(livereload())
	.pipe(notify({ message: 'Styles task completed', onLast: true }));

});
 
// Scripts
// gulp.task('scripts', function() {
// 	return gulp.src([
// 		'scripts/global.js'
// 	])
// 	.pipe(plumber({
// 		errorHandler: function (err) {
// 			console.log(err);
// 			notify.onError({
// 				message: 'Error in scripts task: <%= error.message %>',
// 				sound: noise ? 'Beep' : false
// 			})(err);
// 			this.emit('end');
// 		}
// 	}))
// 	.pipe(rename({ suffix: '.min' }))
// 	.pipe(uglify())
// 	.pipe(gulp.dest('scripts'))
// 	.pipe(livereload())
// 	.pipe(notify({ message: 'Scripts task completed' }));
// });

// Watch - watcher for changes in scss and js files: 'gulp watch' will run these tasks
gulp.task('watch', function() {
	livereload.listen({ basePath: 'css' });
	// Watch .scss files
	gulp.watch('Sass/**/*.scss', ['styles']);
	// Watch .js files
	//gulp.watch('scripts/global.js', ['scripts']);
});

// Build - task to concat and minify all javascript: 'gulp build' will run this task
// gulp.task('vendor-scripts', function() {
// 	return gulp.src([
// 	])
// 	.pipe(plumber({
// 		errorHandler: function (err) {
// 			console.log(err);
// 			notify.onError({
// 				message: 'Error in vendor-scripts task: <%= error.message %>',
// 				sound: noise ? 'Beep' : false
// 			})(err);
// 			this.emit('end');
// 		}
// 	}))
// 	.pipe(concat('vendor.min.js'))
// 	.pipe(uglify())
// 	.pipe(gulp.dest('scripts'))
// 	.pipe(notify({ message: 'Vendor-scripts task completed' }));
// });

// gulp.task('server', function(done) {
//   http.createServer(
//     st({ path: __dirname, index: 'index.html', cache: false })
//   ).listen(8080, done);
// });

// Default - runs the scripts, styles and watch tasks: 'gulp' will run this task
gulp.task('default', ['styles', 'watch']);
