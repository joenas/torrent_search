require 'open-uri'

module TorrentSearch
  DEFAULT_DIR = '.'

  class Download
    def initialize(view, torrent)
      @view = view
      @torrent = torrent
    end

    def perform
      path = @view.ask "Directory to save file (default '#{DEFAULT_DIR}'):"
      path = DEFAULT_DIR if path.empty?
      @view.say "Downloading #{@torrent.name}...", :green
      filename = File.join(path, "#{@torrent.filename}.torrent")
      File.open(filename, "wb") do |saved_file|
        open(@torrent.href, "rb") do |read_file|
          saved_file.write(read_file.read)
        end
      end
      @view.say 'Complete', :green
    end
  end
end