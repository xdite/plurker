require 'fileutils'

namespace :plurker do

  desc "Create a basic plurker.yml configuration file"
  task :setup => :environment do   
    plurk_config = File.join(RAILS_ROOT,"config","plurker.yml")
    unless File.exist?(plurk_config)
      FileUtils.cp File.join(RAILS_ROOT,"vendor", "plugins", "plurker", "plurker.yml.tpl"), plurk_config 
        puts "Configuration created in #{RAILS_ROOT}/config/plurker.yml"
    else
      puts "#{RAILS_ROOT}/config/plurker.yml already exists"
    end
  end 
        
end

