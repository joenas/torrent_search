module TorrentSearch
  class ResultTable
    include Enumerable
    extend Forwardable
    def_delegators :@table, :last, :[], :each, :empty?

    def initialize(search_result)
      @search_result = search_result
      @table = table
    end

    private
    def headers
      ['', :name, :size, :seeders, :leechers]
    end

    def table
      table = [headers]
      counter = 0
      @search_result.each_with_object(table) do |torrent, object|
        counter += 1
        object << [counter, torrent.name, torrent.size, torrent.seeders, torrent.leechers]
      end
    end
  end
end