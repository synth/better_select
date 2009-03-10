require 'fileutils'
# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do

__DIR__ = File.dirname(__FILE__)
RAILS_ROOT = __DIR__ + '/../../..'
##
## Copy over asset files (javascript/css/images) from the plugin directory to public/
##

def copy_files(source_path, destination_path, directory)
  source, destination = File.join(directory, source_path), File.join(RAILS_ROOT, destination_path)
  FileUtils.mkdir(destination) unless File.exist?(destination)
  FileUtils.cp_r(Dir.glob(source+'/*.*'), destination)
end

directory = File.dirname(__FILE__)

[ :stylesheets, :javascripts].each do |asset_type|
  
  source = "/public/#{asset_type}/"
  destination = "/public/#{asset_type}/"
  copy_files(source, destination, directory)
end

end