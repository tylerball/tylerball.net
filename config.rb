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
  blog.name = 'blog'
  blog.sources = "{category}/{year}/{title}/index.html"
  blog.permalink = "{category}/{year}/{month}/{title}"
  blog.layout = 'articles'
  blog.paginate = true
  blog.custom_collections = {
    category: {
      link: '/{category}.html',
      template: '/category.html'
    }
  }
  blog.year_template = 'calendar.html'
end

ignore 'photos/album.html'

ready do
  sitemap.resources.select { |resource| resource.is_a? Middleman::Blog::BlogArticle }
    .select { |a| a.data[:category] == 'photos' }
    .group_by { |a| a.date.year }.each do |year, photos|
      proxy "/photos/#{year}.html", 'photos/album.html', locals: {
        photos: photos
      }
  end
end

page "/articles/feed.xml", layout: false

activate :directory_indexes
