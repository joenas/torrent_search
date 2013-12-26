module TorrentSearch
  module Controllers
    class Search
      ACTIONS = {
        d: :download,
        s: :search,
        q: :quit
      }

      def initialize(view = Views::Search.new)
        @view = view
      end

      def search(search_terms = nil, options = {})
        search_terms ||= @view.search_terms?
        perform_search search_terms, options
        display_menu
        choose_action!
        rescue SocketError
          error 'No network connection?'
      end


    private
      def perform_search(search_terms, options)
        @search_result = Trackers::KickAss::search(search_terms, options)
      end

      def display_menu
        Views::Menu.new(available_actions, @search_result).display
      end

      def download
        Download.new(@search_result).download
      end

      def quit
        CLI::quit
      end

      def choose_action!
        chosen = @view.action?
        send available_actions.fetch(chosen, :invalid_command)
      end

      def invalid_command
        @view.invalid_command!
        choose_action!
      end

      def available_actions
        ACTIONS.dup.tap {|hash| hash.delete(:d) unless @search_result.any? }
      end
    end
  end
end