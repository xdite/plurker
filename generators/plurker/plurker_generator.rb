class PlurkerGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'config/plurker.yml', 'config/plurker.yml'
    end
  end
end