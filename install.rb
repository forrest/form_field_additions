filename = "form_field_additions.js"
dest_js_file = File.expand_path("#{File.dirname(__FILE__)}/../../../public/javascripts/#{filename}")
src_js_file = "#{File.dirname(__FILE__)}/resources/#{filename}"

if File::exists? dest_js_file
  puts "\nA javascript file already exists at #{dest_js_file}.\n"
else
  js = eval "%Q[#{File.read(src_js_file)}]"

  File.open( dest_js_file, 'w' ) do |out|
    out.puts js
  end

  puts "\nInstalling javascript file. Don't forget to include the script in your html (#{filename})."
end  