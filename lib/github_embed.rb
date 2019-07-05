class GithubEmbed < ::Middleman::Extension
  expose_to_template :embed_github

  def initialize(app, options_hash={}, &block)
    # Call super to build options from the options_hash
    super

    require 'tmpdir'
    require 'net/http'
    require 'fileutils'
  end

  def embed_github(path)
    content = get_github_file(normalize(path))
    output = <<~OUTPUT
      <div class="relative">
        <a class="absolute top-1 right-1 f6" href="https://github.com/#{blob(path)}">#{File.basename(path)} ↗︎</a>
        <pre class="pa3 pt4 pt3-ns overflow-x-scroll"><code>#{content}</code></pre>
      </div>
    OUTPUT
  end

  def tmp_path_for(path)
    File.join(tmpdir, File.dirname(path), File.basename(path))
  end

  def get_github_file(path)
    return read(path, File.read(tmp_path_for(path))) if File.exist?(tmp_path_for(path))

    FileUtils.mkdir_p(File.dirname(tmp_path_for(path)))
    content = Net::HTTP.get(URI("https://raw.githubusercontent.com/#{path}"))
    File.write(tmp_path_for(path), content)

    read(path, content)
  end

  def read(path, content)
    lines = /#L(\d+)-?L(\d+)?$/.match(path)

    if lines.nil?
      content
    else
      last = lines[2] ? lines[2].to_i : lines[1].to_i
      content.split("\n")[lines[1].to_i - 1..last - 1].join("\n")
    end
  end

  def normalize(path)
    path.split('/').reject! { |p| p == 'blob' }.join('/')
  end

  def blob(path)
    "#{repo(path)}/blob/#{file(path)}"
  end

  def repo(path)
    path.split('/')[0..1].join('/')
  end

  def file(path)
    path.split('/')[2..-1].join('/')
  end

  def tmpdir
    @tmpdir ||= Dir.mktmpdir
  end
end

Middleman::Extensions.register :githubembed do
  GithubEmbed
end
