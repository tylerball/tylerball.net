module BlogHelpers
  def all_blog_articles
    articles = sitemap.resources.select { |resource| resource.is_a? Middleman::Blog::BlogArticle }
    articles.sort_by! { |a| a.date }.reverse
  end
end
