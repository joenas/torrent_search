require 'torrent_search'
require 'rspec-given'
require 'vcr'
require 'webmock/rspec'
require 'coveralls'
Coveralls.wear!

Dir[File.dirname(__FILE__) + "/support/*.rb"].each{|file| require file}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.before :all do
    path = File.join(Dir.pwd, 'spec/tmp')
    FileUtils.mkdir path unless File.exists? path
  end
end
