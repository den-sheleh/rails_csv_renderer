$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'i18n'
require 'rspec'
require 'rails_csv_renderer/renderable'

if defined? I18n
  I18n.enforce_available_locales = false
  I18n.load_path << File.expand_path('../support/locales/ru.yml', __FILE__)
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
