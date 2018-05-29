require 'yaml'
require 'byebug'
require 'rmagick'
require './lib/photo'

CONTENT_RE = /---(.*)---(.*)/m

Dir.glob('source/photos/**/index.html.markdown.erb').each do |blog_file|
  existing_content = File.read(blog_file)
  existing_data = YAML.load(CONTENT_RE.match(existing_content)[1]).symbolize_keys

  img = Magick::Image.read('source/' + existing_data[:photo]).first
  existing_data[:orientation] = img.columns > img.rows ? 'horizontal' : 'vertical'

  content = ''
  content << YAML.dump(existing_data.stringify_keys)
  content << "---"
  content << CONTENT_RE.match(existing_content)[2]

  puts "writing #{blog_file}"

  File.open(blog_file, 'w') do |file|
    file.write content
  end
end
