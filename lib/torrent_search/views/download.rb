module TorrentSearch
  module Views
    class Download < Base

      def torrent?(max)
        ask("Torrent (0-#{max}):")
      end

      def directory?(default)
        ask "Directory to save file (default '#{default}'):"
      end

      def downloading!(torrent)
        say "Downloading #{torrent.name}...", :blue
      end

      def success
        say 'Complete', :green
      end

      def failure(error, href)
        say "Error: #{error.message} - #{href}", :red
      end
    end
  end
end