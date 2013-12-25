module TorrentSearch
  module Views

    class Menu < Base
      def initialize(actions, search_result)
        @actions = actions
        @search_result = search_result
      end

      def display
        say_status "\n[Results]", '', :green
        if results?
          print_search_result_table
        else
          say 'Nothing found'
        end
        say_status "\n[Actions]", action_menu, :blue
      end

    private
      def results?
        @search_result.any?
      end

      def print_search_result_table
        print_table ResultTable.new(@search_result)
      end

      def action_menu
        @actions.map {|hash| hash.join(": ")}.join("\t")
      end
    end
  end
end