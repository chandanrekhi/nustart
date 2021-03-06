namespace :db do
  desc "Seed your database with data"
  task :seed => :environment do
    Dir.glob("#{RAILS_ROOT}/db/seeds/*.rb").each do |file|
      require file
      
      options = {}
      
      # Command line options
      [:limit].each do |opt|
        if ENV[opt.to_s.upcase]
          options[opt] = ENV[opt.to_s.upcase]
        end
      end
      
      seed_class = (file.gsub(/^#{RAILS_ROOT}\/db\/seeds\/(.*).rb/, '\1')).classify.constantize
      seed_class.plant!(options)
    end
  end
  
  namespace :seeds do
    desc "Generate seed files from your models"
    task :generate => :environment do
      Dir.glob("#{RAILS_ROOT}/app/models/*.rb").each do |file|
        require file

        klass = (file.gsub(/^#{RAILS_ROOT}\/app\/models\/(.*).rb/, '\1')).classify.constantize
        
        File.open("#{RAILS_ROOT}/db/seeds/#{klass.to_s.downcase.pluralize}_seed.rb", 'w') do |f|
          f.write "class #{klass.to_s.pluralize}Seed < Seed::Planter\n"
          klass.columns.each do |col|
            f.write "  attribute :#{col.name}, :#{col.type}\n" unless col.name == 'id'
          end
          f.write "end"
        end
      end
    end
  end
end
