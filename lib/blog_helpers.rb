module BlogHelpers
  def article_title(article)
    unless current_page.path.include?('xml')
      tag = defined?(current_page.blog_data) ? :h1 : :h2
      content_tag(tag) do
        link_to article.title.downcase, article.url, class: 'f3'
      end
    end
  end

  def blog_file(image)
    File.join('/', File.dirname(current_page.path), image)
  end
end
