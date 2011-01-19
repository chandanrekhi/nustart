require 'find'

namespace :db do  

  desc "Backup the database to a file. Options: DIR=base_dir RAILS_ENV=production MAX=30" 

  task :backup => [:environment] do
    datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")    
    base_path = ENV["DIR"] || "db" 
    backup_base = File.join(base_path, 'backup')
    backup_folder = File.join(backup_base, datestamp)
    backup_file = File.join(backup_folder, "#{RAILS_ENV}_dump.sql.gz")   
    FileUtils.mkdir_p(backup_folder)
    db_config = ActiveRecord::Base.configurations[RAILS_ENV]
    pass = ''
    pass = '-p' + db_config['password'] if db_config['password']
    sh "mysqldump -u #{db_config['username']} #{pass} #{db_config['database']} -Q --add-drop-table -O add-locks=FALSE -O lock-tables=FALSE | gzip -c > #{backup_file}"     
    dir = Dir.new(backup_base)
    all_backups = dir.entries[2..-1].sort.reverse
    puts "Created backup: #{backup_file}"
    max_backups = (ENV["MAX"] || 20).to_i
    puts max_backups
    unwanted_backups = all_backups[max_backups..-1] || []
    for unwanted_backup in unwanted_backups
      FileUtils.rm_rf(File.join(backup_base, unwanted_backup))
      puts "deleted #{unwanted_backup}" 
    end
    puts "Deleted #{unwanted_backups.length} backups, #{all_backups.length - unwanted_backups.length} backups available" 
  end

end