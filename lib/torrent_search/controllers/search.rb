module TorrentSearch

  ACTIONS = {
    d: :download,
    s: :search,
    q: :quit
  }

  class SearchController
    def initialize(view = Views::Search.new)
      @view = view
    end

    def search(search_terms = nil, options = {})
      search_terms ||= @view.search_terms?
      @search_result = Trackers::KickAss::Scraper.new(search_terms, options).search
      Views::Menu.new(available_actions, @search_result).display
      choose_action!
      rescue SocketError
        error 'No network connection?'
    end

    def download
      DownloadController.new(@search_result).download
    end

    def quit
      CLI::quit
    end

  private
    def choose_action!
      chosen = @view.action?
      send available_actions.fetch(chosen, :invalid_command)
    end

    def invalid_command
      @view.invalid_command!
      choose_action!
    end

    def available_actions
      ACTIONS.dup.tap {|hash| hash.delete(:d) unless results? }
    end

    def results?
      @search_result.any?
    end
  end
end