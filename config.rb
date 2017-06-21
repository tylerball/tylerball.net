Dir['lib/*'].each(&method(:load))

helpers InlineHelper
helpers BlogHelpers
helpers BlogImageHelpers
helpers AssetHelper

Time.zone = "America/New_York"

set :markdown_engine, :redcarpet
set :markdown, smartypants: true

activate :livereload

activate :external_pipeline,
  name: :webpack,
  command: build? ?
    "./node_modules/webpack/bin/webpack.js --bail -p" :
    "./node_modules/webpack/bin/webpack.js --watch -d --progress --color",
  source: '.tmp/dist',
  latency: 1

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'

activate :blog do |blog|
  blog.name = 'articles'
  blog.prefix = 'articles'
  blog.sources = "{year}/{month}/{title}/index.html"
  blog.permalink = "{year}/{month}/{title}"
  blog.layout = 'articles'
  blog.paginate = true
end

activate :blog do |blog|
  blog.name = 'photos'
  blog.prefix = 'photos'
  blog.sources = "{year}/{title}.html"
  blog.permalink = "{year}/{title}"
  blog.layout = 'photos'
  blog.year_template = 'photos/album.html'
end

activate :blog do |blog|
  blog.name = 'music'
  blog.prefix = 'music'
  blog.sources = "{year}/{title}.html"
  blog.permalink = "{year}/{title}"
  blog.layout = 'music'
end

page "/articles/feed.xml", layout: false

activate :directory_indexes
