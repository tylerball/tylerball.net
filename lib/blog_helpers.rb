module BlogHelpers
  def article_title(article)
    unless current_page.path.include?('xml')
      content_tag(:h2) do
        link_to article.title.downcase, article.url
      end
    end
  end

  def blog_file(image)
    File.join('/', File.dirname(current_page.path), image)
  end
end
