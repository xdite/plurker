# Added support to the plurk.yml file for switching to the new profile design..
# Config parsing needs to happen before files are required.
plurk_config = "#{RAILS_ROOT}/config/plurker.yml"
 
require 'plurker'
PLURK = Plurker.load_configuration(plurk_config)
 
# enable logger before including everything else, in case we ever want to log initialization
Plurker.logger = RAILS_DEFAULT_LOGGER if Object.const_defined? :RAILS_DEFAULT_LOGGER
