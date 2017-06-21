require 'exif'
require 'byebug'
require 'time'
require 'rmagick'
require './lib/photo'

def template_path(file)
    URI::encode(File.join('/photos/',
                          File.dirname(file).split('/').last,
                          File.basename(file)).to_s)
end

CONTENT_RE = /---.*---(.*)/m

Dir.glob('source/photos/**/*.jpg').each do |photo_file|
  next if photo_file.include?('-thumb')
  photo = Photo.new(Pathname.new(photo_file))
  dest_file = File.join(Dir.pwd, "source/photos/#{photo.year}/#{photo.slug}.html.markdown.erb")
  thumb = File.join(Dir.pwd, "source/photos/#{photo.year}/#{photo.slug}-thumb.jpg")

  exif = Exif::Data.new(photo_file)
  date = if exif.date_time_original
    DateTime.parse(exif.date_time_original.to_s).strftime('%F')
  else
    "#{photo.year}-01-01"
  end

  thumb_img = Magick::Image.read(photo_file).first
  target = Magick::Image.new(720, 360)
  thumb_img.resize_to_fill!(720, 360)
  target.composite(thumb_img, Magick::CenterGravity, Magick::CopyCompositeOp).write(thumb)

  filename = template_path(photo_file)
  thumb_path = template_path(thumb)

  content = ''

  content << "---\n"
  content << "title: #{photo.name}\n"
  content << "published: true\n"
  content << "date: #{date}\n"
  content << "photo: #{filename}\n"
  content << "thumb: #{thumb_path}\n"
  content << "---"

  if File.exist?(dest_file)
    content << CONTENT_RE.match(File.read(dest_file))[1]
  end

  puts "writing #{dest_file}"

  File.open(dest_file, 'w') do |file|
    file.write content
  end
end
