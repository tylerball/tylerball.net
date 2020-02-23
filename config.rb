Dir['lib/*'].each(&method(:load))

helpers BlogHelpers
helpers AssetHelper

Time.zone = "America/New_York"

configure :production do
  set :hostname, 'https://tylerball.net'
end

configure :development do
  set :hostname, 'http://localhost:4567'
end

set :markdown,
  smartypants: true,
  footnotes: true,
  strikethrough: true,
  fenced_code_blocks: true
set :markdown_engine, :redcarpet

activate :livereload, host: '0.0.0.0'

activate :githubembed

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

page 'photos/ongoing/*', layout: :ongoing
ignore 'photos/album.html'
ignore 'photos/album_grid.html'
ignore 'stylesheets/all'

ready do
  sitemap.resources.select { |resource| resource.is_a? Middleman::Blog::BlogArticle }
    .select { |a| a.data[:category] == 'photos' }
    .group_by { |a| a.date.year }.each do |year, photos|
      proxy "/photos/#{year}.html", 'photos/album_grid.html', locals: {
        photos: photos,
        year: year,
      }
  end
end

page "/feed.xml", layout: false

activate :directory_indexes
