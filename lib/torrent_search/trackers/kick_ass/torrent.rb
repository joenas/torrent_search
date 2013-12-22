
module TorrentSearch
  module Trackers
    module KickAss
      class Torrent

        def initialize(row)
          @row = row
        end

        def name
          @row.search('.torrentname a')[1].text
        end

        def size
          @row.search('td')[1].text
        end

        def seeders
          @row.search('td')[4].text
        end

        def leechers
          @row.search('td')[5].text
        end

        def href
          url.match(/(.*)\?/)[1]
        end

        def filename
          url.match(/title=(.*)/)[1]
        end

        def url
          @row.search('.iaconbox a').last.attr('href')
        end
      end
    end
  end
end