class Photo
  attr_reader :path

  def initialize(path)
    @path = path
    @filename = path.basename.to_s.gsub(path.extname, '')
  end

  def year
    /\d{4}/.match(path.to_s)[0]
  end

  def url
    URI.escape(path.to_s)
  end

  def slug
    @filename.gsub(' ', '-').delete(',').gsub(/-\d{4}$/, '').downcase
  end

  def name
    /\d+-(.*)/.match(@filename)[1]
  end

  def name_without_year
    name.gsub(/\, [\d-]+$/, '')
  end
end

class Hash
  def symbolize_keys
    self.each_with_object({}){|(k,v), h| h[k.to_sym] = v}
  end

  def stringify_keys
    self.each_with_object({}){|(k,v), h| h[k.to_s] = v}
  end
end
