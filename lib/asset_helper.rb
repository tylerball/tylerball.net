module AssetHelper
  DIST_PATH = File.join(Dir.pwd, '.tmp/dist')
  MANIFEST_PATH = File.join(DIST_PATH, 'manifest.json')

  def webpack_asset_path(path)
    manifest = JSON.parse(File.read(MANIFEST_PATH))
    asset_path = manifest[path]
    raise "Can't find #{path} in webpack assets. See manifest.json for complete list." unless asset_path
    "#{config[:hostname]}#{File.absolute_path(asset_path, '/')}"
  end
end
