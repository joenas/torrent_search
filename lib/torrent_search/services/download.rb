require "httparty"

module TorrentSearch
  module Services
    class Download
      def initialize(path, torrent)
        @path = path
        @torrent = torrent
      end

      def perform(view)
        if success?
          save!
          view.success
        else
          view.failure response, @torrent.href
        end
      end

      def success?
        response.code == 200
      end

      def filename
        File.join(@path, "#{@torrent.filename}.torrent")
      end

    private
      def save!
        File.open(filename, "wb") do |file|
          file.write response.parsed_response
        end
      end

      def response
        @response ||= HTTParty.get(@torrent.href)
      end
    end
  end
end