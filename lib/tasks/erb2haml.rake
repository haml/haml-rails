namespace :haml do
  desc 'Convert html.erb to html.haml each file in app/views'
  task :erb2haml do

    erb_files = Dir.glob('app/views/**/*.erb').select { |f| File.file? f}
    haml_files = Dir.glob('app/views/**/*.haml').select { |f| File.file? f}
    failed_files = []

    if erb_files.empty?
      puts "No .erb files found. Task will now exit."
      exit
    end

    erb_files_to_convert = erb_files.dup

    haml_files_w_out_ext = haml_files.map { |f| f.gsub(/\.haml\z/, '') }

    # Get a list of all those erb files that already seem to have .haml equivalents

    already_existing = erb_files.select { |f| short = f.gsub(/\.erb\z/, ''); haml_files_w_out_ext.include?(short) }

    puts '-'*80

    if already_existing.any?
      puts "Some of your .html.erb files seem to already have .haml equivalents:"
      already_existing.map { |f| puts "\t#{f}" }

      if ENV.has_key?("HAML_RAILS_OVERWRITE_HAML") && (ENV["HAML_RAILS_OVERWRITE_HAML"] == "false")
        should_overwrite = 'n'
      else
        # Ask the user whether he/she would like to overwrite them.
        begin
          puts "Would you like to overwrite these .haml files? (y/n)"
          should_overwrite = STDIN.gets.chomp.downcase[0]
        end until ['y', 'n'].include?(should_overwrite)
      end
      puts '-'*80

      # If we are not overwriting, remove each already_existing from our erb_files list
      if should_overwrite == 'n'
        erb_files_to_convert = erb_files - already_existing

        if erb_files_to_convert.empty?
          # It is possible no .erb files remain, after we remove already_existing
          puts "No .erb files to convert"
        end
      else
        # Delete the current .haml
        already_existing.each { |f| File.delete(f.gsub(/\.erb\z/, '.haml')) }
      end
    end

    erb_files_to_convert.each do |file|
      puts "Generating HAML for #{file}..."
      `html2haml #{file} #{file.gsub(/\.erb\z/, '.haml')}`
      if !$?.success?
        puts "Error: html2haml failed to convert #{file} to HAML. Please check the file for errors."
        failed_files << file
      end
    end

    successful_files = erb_files_to_convert - failed_files

    puts '-'*80

    puts "HAML generated for the following files:"
    successful_files.each do |file|
      puts "\t#{file}"
    end

    if failed_files.any?
      puts "The following files failed to convert:"
      failed_files.each do |file|
        puts "\t#{file}"
      end
      puts "Please check the above files for errors and that you have html2haml installed properly."
    end

    puts '-'*80
    if ENV.has_key?("HAML_RAILS_DELETE_ERB") && (ENV["HAML_RAILS_DELETE_ERB"] == "true")
      should_delete = 'y'
    else
      begin
        puts 'Would you like to delete the original .erb files that successfully converted? (This is not recommended unless you are under version control.) (y/n)'
        should_delete = STDIN.gets.chomp.downcase[0]
      end until ['y', 'n'].include?(should_delete)
    end
    if should_delete == 'y' && successful_files.any?
      puts "Deleting original .erb files."
      File.delete(*successful_files)
    elsif should_delete == 'y' && successful_files.empty?
      puts "No successfully converted files to delete."
    else
      puts "Please remember to delete your .erb files once you have ensured they were translated correctly."
    end

    puts '-'*80
    puts "Task complete!"
  end
end
