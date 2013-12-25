require 'spec_helper'

describe TorrentSearch::Download do
  Given(:path){File.join(Dir.pwd, 'spec/tmp')}
  Given(:torrent){OpenStruct.new(href: 'http://asdf.com', filename: 'asdf')}
  Given(:created_file){File.join(path, "#{torrent.filename}.torrent")}
  Given(:view){double 'view'}

  subject{described_class.new(path, torrent)}

  before :each do
    FileUtils.rm created_file, force: true
  end

  describe '#perform' do
    When{subject.perform view}

    context 'with 200 success' do
      Given{stub_request(:any, "asdf.com").to_return(status: 200, body: 'abc')}
      Given{view.should receive(:success)}
      Then{a_request(:get, "asdf.com").should have_been_made.once}
      And{File.read(created_file).should eq 'abc'}
    end

    context 'with 404 not found' do
      Given{stub_request(:any, "asdf.com").to_return(status: 404)}
      Given{view.should receive(:failure)}
      Then{a_request(:get, "asdf.com").should have_been_made.once}
      And{File.exists?(created_file).should be_false}
    end

    context 'with 500 error' do
      Given{stub_request(:any, "asdf.com").to_return(status: 500)}
      Given{view.should receive(:failure)}
      Then{a_request(:get, "asdf.com").should have_been_made.once}
      And{File.exists?(created_file).should be_false}
    end
  end
end