filename = "form_field_additions.js"
dest_js_file = File.expand_path("#{File.dirname(__FILE__)}/../../../public/javascripts/#{filename}")

if File::exists? dest_js_file
  system("rm #{dest_js_file}")
  puts "\nRemoving javascript file #{dest_js_file}.\n"
else
  puts "\nCould not find javascript file to remove (#{filename})."
end