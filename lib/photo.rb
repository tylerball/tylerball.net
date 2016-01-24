class Photo
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def url
    URI.escape(path.to_s)
  end

  def slug
    path.basename.to_s.gsub(path.extname, '')
  end

  def name
    /\d+-(.*)/.match(slug)[1]
  end

  def name_without_year
    name.gsub(/\, [\d-]+$/, '')
  end
end
