require 'mechanize'

module TorrentSearch
  module Trackers
    module KickAss
      class Scraper

        BASE_URL = "http://kickass.to/usearch"
        LIMIT = 10

        def initialize(search_terms, options = {})
          @search_terms = search_terms
          @options = options
        end

        def search
          search_results.map do |row|
            Torrent.new(row)
          end
        end

        private

        def search_results
          page.search('table.data tr').tap do |results|
            results.shift
          end.take(limit)
        end

        def limit
          @options.fetch 'limit', LIMIT
        end

        def page
          @page ||= agent.get search_url
        end

        def search_url
          terms = @search_terms.join("%20")
          [BASE_URL, terms, search_append].join "/"
        end

        def search_append
          "?field=seeders&sorder=desc"
        end

        def agent
          @agent ||= Mechanize.new { |agent|
            agent.user_agent_alias = 'Mac Safari'
          }
        end
      end
    end
  end
end