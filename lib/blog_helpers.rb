module BlogHelpers
  def all_blog_articles
    sitemap.resources.select { |resource| resource.is_a? Middleman::Blog::BlogArticle }
  end

  def all_blog_articles_by_date
    all_blog_articles.sort_by! { |a| a.date }.reverse
  end

  def article_title(article)
    link_to article.title.downcase, article.url
  end
end
