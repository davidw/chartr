# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do
  
  ##
  ## Copy over asset files (javascript/css/images) from the plugin directory to public/
  ##
  
  plotr = "plotr-#{PLOTR_VERSION}"
  chartr_path = RAILS_ROOT + "/vendor/plugins/chartr"
  destination = RAILS_ROOT + "/public/javascripts/chartr"
  
  # Files to be copied
  files = ["#{chartr_path}/#{plotr}/plotr-proto16/plotr.js", "#{chartr_path}/#{plotr}/lib/excanvas/excanvas.js"]
  
  # Create destination directory (RAILS_ROOT/public/javascripts/chartr)
  FileUtils.mkdir_p(destination)
  
  # Copy each file to the destination directory
  files.each do |f|
    FileUtils.cp_r(f, destination)
  end
end