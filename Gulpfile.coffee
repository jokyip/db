_ = require 'lodash'
gulp = require 'gulp'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
fs = require 'fs'
util = require 'util'
concat = require 'gulp-concat'
rework = require 'gulp-rework'
imprt = require 'rework-import'
reworkNPM = require 'rework-npm'
templateCache = require 'gulp-angular-templatecache'

gulp.task 'default', ['css', 'coffee']

gulp.task 'config', ->
  params = _.pick process.env, 'OAUTH2_SCOPE', 'AUTHURL', 'CLIENT_ID', 'DBURL'
  fs.writeFileSync 'www/js/config.json', util.inspect(params)

gulp.task 'cssAll', ->
  gulp.src 'www/css/index.css'
    .pipe rework reworkNPM shim: 'angular-toastr': 'dist/angular-toastr.css'
    .pipe concat 'css.css'
    .pipe gulp.dest 'www/css/'

gulp.task 'scssAll', ->
  gulp.src 'scss/ionic.app.scss'
    .pipe sass()
    .pipe concat 'scss.css'
    .pipe gulp.dest 'www/css/'

gulp.task 'css', ['cssAll', 'scssAll'], ->
  gulp.src ['www/css/css.css', 'www/css/scss.css']
    .pipe concat 'ionic.app.css'
    .pipe gulp.dest 'www/css'

gulp.task 'coffee', ['config', 'template'], ->
  browserify(entries: ['./www/js/index.coffee'])
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe(source('index.js'))
    .pipe(gulp.dest('./www/js/'))

gulp.task 'template', ->
  gulp.src 'www/templates/**/*.html'
    .pipe templateCache root: 'templates', standalone: true
    .pipe gulp.dest 'www/js'
