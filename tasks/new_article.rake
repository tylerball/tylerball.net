require 'date'
require 'active_support/inflector'

task :new_article do
  STDOUT.write 'Article name: '
  input = STDIN.gets.strip
  date = Date.today.strftime('%Y-%m-%d')
  dir = "source/words/#{Date.today.strftime('%Y/%m')}/#{input.parameterize}"
  Dir.mkdir(dir)
  content = "---\n"
  content << "title: #{input}\n"
  content << "published: false\n"
  content << "date: #{date}\n"
  content << "---\n\n"
  File.open(File.join(dir, 'index.html.markdown'), 'w') do |file|
    file.write content
  end
end
