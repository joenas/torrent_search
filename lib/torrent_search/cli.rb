require 'thor'
require 'torrent_search/default_command'
require 'torrent_search/download'
require 'torrent_search/result_table'
require 'torrent_search/search'
require 'torrent_search/version'

module TorrentSearch

  class CLI < Thor
    include Thor::Actions
    extend DefaultCommand

    desc 'version', 'Shows version'
    def version(*)
      say VERSION
    end

    default_command :search
    desc '[TERMS]', 'tsearch help search for options'
    method_option :irresponsible,
                  type: :boolean,
                  aliases: '-i',
                  desc: 'Include IrresponsibleModule smell in output.'

    def search(*search_terms)
      Search.new(self).perform(search_terms)
      rescue SocketError
        error 'No network connection?'
    end
  end
end
