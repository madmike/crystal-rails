require "bundler/gem_tasks"

desc "Remove the app directory"
task :clean do
  rm_rf 'app'
end

desc "Generate the JavaScript assets"
task javascripts: :submodule do
  Rake.rake_output_message 'Generating javascripts'

  target_dir = "app/assets/javascripts"
  target_ui_dir = "#{target_dir}/crystal"
  mkdir_p target_ui_dir

  Dir.glob("crystal/js/**/*.js").each do |path|
    basename = File.basename(path)
    dep_modules = get_js_dependencies(basename).map(&method(:remove_js_extension))
    File.open("#{target_ui_dir}/#{basename}", "w") do |out|
      dep_modules.each do |mod|
        out.write("//= require jquery-ui/#{mod}\n")
      end
      out.write("\n") unless dep_modules.empty?
      source_code = File.read(path)
      source_code.gsub!('@VERSION', version)
      protect_copyright_notice(source_code)
      out.write(source_code)
    end
  end
end
