require 'thor'
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
    desc 'smell FILE(S)|DIR', 'Shorthand: preek [FILES]'
    method_option :irresponsible,
                  type: :boolean,
                  aliases: '-i',
                  desc: 'Include IrresponsibleModule smell in output.'

    method_option :compact,
                  type: :boolean,
                  aliases: '-c',
                  desc: 'Compact output.'

    method_option :verbose,
                  type: :boolean,
                  aliases: '-v',
                  desc: 'Report files with no smells.'


    def search(*search_terms)
      puts search_terms.inspect
    end
  end
end
