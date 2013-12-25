module TorrentSearch
  module Views
    class Search < Base

      def action?
        ask("Choose:").to_sym
      end

      def search_terms?
        ask("Search for:").split
      end
    end
  end
end