require 'yaml'
require 'exif'
require 'byebug'
require 'time'
require 'rmagick'
require './lib/photo'

class Hash
  def symbolize_keys
    self.each_with_object({}){|(k,v), h| h[k.to_sym] = v}
  end

  def stringify_keys
    self.each_with_object({}){|(k,v), h| h[k.to_s] = v}
  end
end

def template_path(file)
  root = Pathname.new(File.join(Dir.pwd, 'source'))
  file = Pathname.new(file)
  URI::encode('/' + file.relative_path_from(root).to_s)
end

CONTENT_RE = /---(.*)---(.*)/m

Dir.glob('source/photos/*/*.jpg').each do |photo_file|
  next if photo_file.include?('-thumb')
  photo = Photo.new(Pathname.new(photo_file))
  dest_dir = FileUtils.mkdir_p(File.join(Dir.pwd, "source/photos/#{photo.year}/#{photo.slug}")).first
  dest_post = File.join(dest_dir, 'index.html.markdown.erb')
  thumb_img = Magick::Image.read(photo_file).first
  orientation = thumb_img.columns > thumb_img.rows ? 'horizontal' : 'vertical'

  unless File.exist?(dest_post)
    thumb = File.join(dest_dir, "#{photo.slug}-thumb.jpg")
    dest_image = File.join(dest_dir, "#{photo.slug}.jpg")
    FileUtils.cp(photo_file, dest_image)

  exif = Exif::Data.new(photo_file)
    date = if exif.date_time_original
      DateTime.parse(exif.date_time_original.to_s).strftime('%F')
    else
      "#{photo.year}-01-01"
    end

    target = Magick::Image.new(720, 360)
    thumb_img.resize_to_fill!(720, 360)
    target.composite(thumb_img, Magick::CenterGravity, Magick::CopyCompositeOp).write(thumb)

    filename = template_path(dest_image)
    thumb_path = template_path(thumb)
  end

  data = {
    title: photo.name,
    published: true,
    date: date,
    photo: filename,
    thumb: thumb_path,
    orientation: orientation,
  }
  content = ''

  if File.exist?(dest_post)
    existing_content = File.read(dest_post)
    existing_data = YAML.load(CONTENT_RE.match(existing_content)[1]).symbolize_keys
    content << YAML.dump(data.merge!(existing_data).stringify_keys)
    content << "---"
    content << CONTENT_RE.match(existing_content)[2]
  else
    content << "---"
    content << YAML.dump(data)
    content << "---\n"
  end

  puts "writing #{dest_post}"

  File.open(dest_post, 'w') do |file|
    file.write content
  end
end
