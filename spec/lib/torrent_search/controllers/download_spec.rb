require 'spec_helper'

describe TorrentSearch::Controllers::Download do
  Given(:search_result){['asdf']}
  Given(:view){double 'view'}
  Given{view.stub(:downloading!)}

  subject{described_class.new(search_result, view)}

  describe '#download' do
    Given(:torrent){search_result.first}
    Given(:path){'.'}
    Given(:download_double){double 'download'}

    Given{view.stub(:directory?).and_return(path)}

    Given{TorrentSearch::Services::Download.should_receive(:new).with(path, torrent).and_return(download_double)}
    Given{download_double.should_receive(:perform).with(view)}

    When{subject.download}

    describe 'choosing download dir' do
      Given{view.stub(:torrent?).and_return('0')}

      context 'with default dir' do
        Given(:path){described_class::DEFAULT_DIR}
        Given{view.stub(:directory?).and_return('')}
        Then{}
      end

      context 'given a dir' do
        Given(:path){'/tmp'}
        Then{}
      end
    end

    describe 'choosing torrent' do
      context 'with invalid choice then valid choice' do
        Given{view.stub(:torrent?).and_return('1', '0')}
        Given{view.should_receive(:invalid_option!)}
        Then{}
      end
    end
  end
end