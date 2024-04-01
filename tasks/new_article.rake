require 'date'
require 'fileutils'
require 'active_support/inflector'

begin
  task :new_article do
    section = ARGV.size > 1 ? ARGV.last : 'words'
    STDOUT.write 'Article name: '
    input = STDIN.gets.strip
    date = Date.today.strftime('%Y-%m-%d')
    dir = "source/#{section}/#{Date.today.strftime('%Y/%m')}/#{input.parameterize}"
    FileUtils.mkdir_p(dir)
    content = "---\n"
    content << "title: \"#{input}\"\n"
    content << "published: false\n"
    content << "date: #{date}\n"
    content << "---\n\n"
    File.open(File.join(dir, 'index.html.markdown'), 'w') do |file|
      file.write content
    end
  end
rescue RunTimeError
end
