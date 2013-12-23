require "httparty"

module TorrentSearch
  DEFAULT_DIR = '.'

  class Download
    def initialize(view, torrent)
      @view = view
      @torrent = torrent
    end

    def perform
      save! filename
      say 'Complete', :green
    end

  private
    def filename
      File.join(path, "#{@torrent.filename}.torrent")
    end

    def path
      path = @view.ask "Directory to save file (default '#{DEFAULT_DIR}'):"
      path.empty? ? DEFAULT_DIR : path
    end

    def save!(filename)
      say "Downloading #{@torrent.name}...", :green
      File.open(filename, "wb") do |file|
        file.write HTTParty.get(@torrent.href).parsed_response
      end
    end

    def say(*args)
      @view.say *args
    end
  end
end