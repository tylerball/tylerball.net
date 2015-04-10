class Photo
  attr_reader :path, :slug

  def initialize(path)
    @path = path
  end

  def slug
    @path.basename.to_s.gsub(@path.extname, '')
  end
end
