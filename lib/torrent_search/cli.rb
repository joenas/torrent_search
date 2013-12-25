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
      SearchController.new.search search_terms, options
    end

  end
end

trap('INT') { TorrentSearch::CLI::quit }