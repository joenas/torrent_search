module TorrentSearch
  module Controllers
    class Download
      DEFAULT_DIR = '.'

      def initialize(search_result, view = Views::Download.new)
        @search_result = search_result
        @view = view
      end

      def download
        torrent = choose_torrent!
        path = choose_path!
        @view.downloading! torrent
        Services::Download.new(path, torrent).perform @view
      end

    private
      def choose_path!
        path = @view.directory? DEFAULT_DIR
        path.empty? ? DEFAULT_DIR : path
      end

      def choose_torrent!
        index = ''
        until valid_choice?(index)
          index = @view.torrent?(search_result_range.max)
          return @search_result[index.to_i] if valid_choice?(index)
          @view.invalid_option!
        end
      end

      def valid_choice?(index)
        index.match(/\A\d+\z/) && is_in_search_result?(index)
      end

      def is_in_search_result?(index)
        search_result_range.member?(index.to_i)
      end

      def search_result_range
        @range ||= Range.new(0, @search_result.length, true)
      end
    end
  end
end