###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

activate :directory_indexes

set :markdown_engine, :redcarpet

###
# Helpers
###

activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

activate :inliner

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

activate :blog do |blog|
  blog.name = 'articles'
  blog.prefix = 'articles'
  blog.sources = "{category}/{year}/{month}-{day}-{title}.html"
  blog.permalink = "{category}/{year}/{title}.html"
end

activate :blog do |blog|
  blog.name = 'photos'
  blog.prefix = 'photos'
  blog.sources = "{title}.html"
  blog.permalink = "{title}.html"
  blog.layout = 'photos'
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'tylerball.net'
  deploy.path   = '/var/www/tylerball.net'
  deploy.user  = 'tyler'
end
