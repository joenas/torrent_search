module TorrentSearch
  class Search
    def initialize(view)
      @view = view
    end

    def perform(search_terms, options = {})
      search_result = Trackers::KickAss::Scraper.new(search_terms, options).search
      @view.print_table ResultTable.new(search_result)
      choose_action search_result
    end

  private
    def choose_action(search_result)
      selected = ask("Choose torrent (0 to search again):").to_i
      if selected != 0
        download search_result[selected-1]
      else
        search_again
      end
    end

    def ask(question)
      @view.ask question
    end

    def search_again
      perform ask("Search for:").split
    end

    def download(torrent)
      Download.new(@view, torrent).perform
    end
  end
end