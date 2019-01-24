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

  def photos_by_year(year)
    photos_grouped_by_year[year]
  end

  def photos_grouped_by_year
    blog.articles.select do |article|
      article.data[:category] == 'photos' && !article.data[:essay]
    end.group_by do |article|
      if article.data[:original_date]
        if article.data[:original_date].class == Date
          article.data[:original_date].year
        else
          Date.parse(article.data[:original_date]).year
        end
      else
        article.date.year
      end
    end
  end
end
