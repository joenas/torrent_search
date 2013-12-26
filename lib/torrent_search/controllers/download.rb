module TorrentSearch
  module Controllers
    class Download
      DEFAULT_DIR = '.'

      def initialize(search_result, view = Views::Download.new)
        @search_result = search_result
        @view = view
      end

      def download
        perform_download choose_torrent!, choose_path!
      end

    private
      def perform_download(torrent, path)
        @view.downloading! torrent
        download = Services::Download.new(path, torrent)
        download.perform @view
        if download.success? && OS.os_x? && @view.open?
          open download.filename
        end
      end

      def open(filename)
        `open #{filename}`
      end

      def choose_torrent!
        while
          index = @view.torrent?(search_result_range.max)
          return @search_result[index.to_i] if valid_choice?(index)
          @view.invalid_option!
        end
      end

      def choose_path!
        path = @view.directory? DEFAULT_DIR
        path.empty? ? DEFAULT_DIR : path
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