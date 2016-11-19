require 'find'
require 'pathname'
require 'lib/photo'

module BlogImageHelpers
  def blog_image(image)
    Photo.new(Find.find(current_page.path)
        .grep(/#{image}/)
        .first.to_s[%r{/blog/.+}].to_s)
  end

  def blog_post_images(dir = current_page.path)
    source_dir = File.join(Middleman::Application.root, config[:source])
    parent = Pathname.new(source_dir)
    Dir.glob("#{File.join(source_dir, dir.split('.')[0])}/*.{jpg}").map do |p|
      Photo.new((parent + p).relative_path_from(parent))
    end
  end
end
