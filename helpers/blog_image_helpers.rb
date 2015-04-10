require 'find'
require 'pathname'
require 'lib/photo'

module BlogImageHelpers
  def blog_image(image)
    Photo.new(Find.find(current_page.path)
        .grep(/#{image}/)
        .first.to_s[%r{/blog/.+}].to_s)
  end

  def blog_post_images
    parent = Pathname.new(source_dir)
    Dir.glob("#{File.join(source_dir, current_page.path.split('.')[0])}/*.{jpg}").map do |p|
      Photo.new((parent + p).relative_path_from(parent))
    end
  end
end
