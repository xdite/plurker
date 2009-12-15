#unless defined?(ActiveSupport) and defined?(ActiveSupport::JSON)


require 'rubygems'
require 'json'
require 'mechanize'



module Plurker
  @plurker_configuration = {}
  @raw_plurker_configuration = {}
  
  class << self
     def load_configuration(plurker_yaml_file)
       return false unless File.exist?(plurker_yaml_file)
       @raw_plurker_configuration = YAML.load(ERB.new(File.read(plurker_yaml_file)).result)
       if defined? RAILS_ENV
         @raw_plurker_configuration = @raw_plurker_configuration[RAILS_ENV]
       end
       Thread.current[:plk_api_config] = @raw_plurker_configuration unless Thread.current[:plk_api_config]
       apply_configuration(@raw_plurker_configuration)
       
     end
     
     def apply_configuration(config)
       ENV['PLURK_API_KEY']             = config['api_key']

       @plurker_configuration = config  # must be set before adapter loaded
       plurker_config
     end

     def plurker_config
       @plurker_configuration
     end
     
  end
end

require 'plurker/easy_class_maker'
require 'plurker/base'
require 'plurker/logging'