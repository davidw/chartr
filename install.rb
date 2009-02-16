# Workaround a problem with script/plugin and http-based repos.
# See http://dev.rubyonrails.org/ticket/8189
Dir.chdir(Dir.getwd.sub(/vendor.*/, '')) do

  ##
  ## Copy over asset files (javascript/css/images) from the plugin
  ## directory to public/
  ##

  chartr_path = RAILS_ROOT + "/vendor/plugins/chartr"
  destination = RAILS_ROOT + "/public/javascripts/chartr"

  flotr = "flotr/release/prototype/flotr-0.2.0-test/flotr"

  # Files to be copied
  files = ["#{chartr_path}/#{flotr}/flotr-min.js",
           "#{chartr_path}/#{flotr}/lib/canvastext.js",
           "#{chartr_path}/#{flotr}/lib/canvas2image.js"]

  # Create destination directory (RAILS_ROOT/public/javascripts/chartr)
  FileUtils.mkdir_p(destination)

  # Copy each file to the destination directory
  files.each do |f|
    FileUtils.cp_r(f, destination)
  end
end
