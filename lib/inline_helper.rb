module InlineHelper
  def stylesheet_inline_tag(path)
    content_tag(:style) do
      begin
        find_resource(path).render
      rescue NoMethodError
        raise "Unable to render #{path}"
      end
    end
  end

  private

  def find_resource(path)
    sitemap.resources.select do |resource|
      File.basename(resource.source_file, File.extname(resource.source_file)) == path
    end.first
  end
end
