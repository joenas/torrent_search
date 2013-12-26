# spec/support/vcr_setup.rb
VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
  c.default_cassette_options = { :match_requests_on => [:query, :method, :uri, :body], record: :new_episodes }
end