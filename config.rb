require 'lib/inline_helper'
require 'lib/blog_image_helpers'

helpers InlineHelper
helpers BlogImageHelpers

Time.zone = "America/New_York"

set :markdown_engine, :redcarpet
set :markdown, smartypants: true

activate :livereload

activate :external_pipeline,
  name: :gulp,
  command: "gulp #{'watch' unless build?}",
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
  blog.sources = "{title}.html"
  blog.permalink = "{title}.html"
  blog.layout = 'photos'
end

page "/articles/feed.xml", layout: false

activate :directory_indexes

configure :build do
end
