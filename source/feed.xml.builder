xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  _blog = blog(:blog)
  site_url = "http://tylerball.net/"
  xml.title "tylerball.net"
  xml.subtitle ""
  xml.id URI.join(site_url, _blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, _blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated(_blog.articles.first.date.to_time.iso8601) unless _blog.articles.empty?
  xml.author { xml.name "Tyler Ball" }

  _blog.articles[0..10].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated DateTime.new(article.date.year, article.date.month, article.date.day, 12).iso8601
      xml.author { xml.name "Tyler Ball" }
      xml.content partial("list_#{article.data[:category]}", locals: {article: article}), "type" => "html"
    end
  end
end
