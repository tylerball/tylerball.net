module BlogHelpers
  def all_blog_articles
    articles = blog(:music).articles + blog(:articles).articles
    articles.sort_by! { |a| a.date }.reverse
  end
end
