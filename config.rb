Time.zone = "America/New_York"

set :markdown_engine, :redcarpet
set :markdown, smartypants: true

###
# Helpers
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :inliner
activate :imageoptim

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

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'tylerball.net'
  deploy.path   = '/var/www/tylerball.net'
  deploy.user  = 'tyler'
end
