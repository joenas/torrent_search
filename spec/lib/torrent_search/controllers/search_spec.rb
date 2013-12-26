require 'spec_helper'

describe TorrentSearch::Controllers::Search do

  Given(:view){double 'view'}

  subject{described_class.new(view)}

  describe '#search' do
    Given(:search_terms){'asdf'}
    Given(:options){{}}
    Given(:tracker){TorrentSearch::Trackers::KickAss}

    Given{tracker.should_receive(:search).with(search_terms, options).and_return(search_result)}

    When{subject.search(search_terms, options)}

    context 'with no search result' do
      Given(:search_result){[]}

      context 'with invalid command then quit' do
        Given{view.stub(:action?).and_return(:d, :q)}
        Given{view.stub(:invalid_command!)}

        Given{TorrentSearch::CLI.should_receive(:quit)}
        Then{}
      end

      context 'with search again then quit' do
        Given(:new_search_terms){'fdsa'}

        Given{view.stub(:action?).and_return(:s, :q)}
        Given{view.stub(:search_terms?).and_return(new_search_terms)}

        Given{tracker.should_receive(:search).with(new_search_terms, options).and_return(search_result)}
        Given{TorrentSearch::CLI.should_receive(:quit)}
        Then{}
      end
    end

    context 'with search result' do
      Given(:search_result){[OpenStruct.new(name: '', size:'', seeders: '', leechers:'')]}

      describe 'download' do
        Given{view.stub(:action?).and_return(:d)}

        Given(:download_double){double 'download'}
        Given{TorrentSearch::Controllers::Download.should_receive(:new).with(search_result).and_return(download_double)}
        Given{download_double.should_receive :download}
        Then{}
      end
    end

  end

end