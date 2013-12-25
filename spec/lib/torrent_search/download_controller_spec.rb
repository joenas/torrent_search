require 'spec_helper'

describe TorrentSearch::DownloadController do
  Given(:default_dir){TorrentSearch::DownloadController::DEFAULT_DIR}
  Given(:path){'.'}

  Given(:search_result){['asdf']}
  Given(:torrent){search_result.first}

  Given(:view){double 'view'}
  Given(:download_double){double 'download'}
  Given{view.stub(:downloading!)}

  subject{described_class.new(search_result, view)}

  describe '#download' do
    Given{TorrentSearch::Download.should_receive(:new).with(path, torrent).and_return(download_double)}
    Given{download_double.should_receive(:perform).with(view)}
    Given{view.stub(:directory?).and_return(path)}

    When{subject.download}

    describe 'choosing download dir' do
      Given{view.stub(:torrent?).and_return('0')}

      context 'with default dir' do
        Given(:path){default_dir}
        Given{view.stub(:directory?).and_return('')}
        Then{}
      end

      context 'given a dir' do
        Given(:path){'/tmp'}
        Then{}
      end
    end

    describe 'choosing torrent' do
      context 'with valid choice' do
        Given{view.stub(:torrent?).and_return('0')}
        Then{}
      end

      context 'with invalid choice' do
        Given{view.stub(:torrent?).and_return('1', '0')}
        Given{view.should_receive(:invalid_option!)}
        Then{}
      end
    end
  end
end