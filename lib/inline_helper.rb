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
      /#{path}\.css$/.match(resource.source_file)
    end.first
  end
end
