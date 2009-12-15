class PlurkGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'config/plurk.yml', 'config/plurk.yml'
    end
  end
end