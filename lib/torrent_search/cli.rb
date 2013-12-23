require 'thor'
require 'torrent_search/default_command'
require 'torrent_search/download'
require 'torrent_search/result_table'
require 'torrent_search/menu'
require 'torrent_search/version'

module TorrentSearch
  class CLI < Thor
    include Thor::Actions
    extend DefaultCommand

    def self.quit
      puts "\nQuitting.."
      exit 0
    end

    desc 'version', 'Shows version'
    def version(*)
      say VERSION
    end

    default_command :search
    desc '[TERMS]', 'tsearch help search for options'
    method_option :limit,
                  type: :numeric,
                  aliases: '-l',
                  desc: 'Limit search results, default 10'

    def search(*search_terms)
      search_result = Trackers::KickAss::Scraper.new(search_terms, options).search
      Menu.new(self, search_result).display
      rescue SocketError
        error 'No network connection?'
    end

  end
end

trap('INT') { TorrentSearch::CLI::quit }