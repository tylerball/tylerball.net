module BlogHelpers
  def article_title(article)
    link_to article.title.downcase, article.url
  end

  def blog_file(image)
    File.join('/', File.dirname(current_page.path), image)
  end
end
