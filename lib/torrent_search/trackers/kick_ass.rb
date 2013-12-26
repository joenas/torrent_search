require 'torrent_search/trackers/kick_ass/scraper'
require 'torrent_search/trackers/kick_ass/torrent'
module TorrentSearch
  module Trackers
    module KickAss
      def self.search(search_terms, options = {})
        Scraper.new(search_terms, options).search
      end
    end
  end
end