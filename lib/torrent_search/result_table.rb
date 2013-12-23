module TorrentSearch
  class ResultTable
    include Enumerable
    extend Forwardable
    def_delegators :@table, :[], :each, :empty?

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
        object << [counter, *values(torrent)]
        counter += 1
      end
    end

    def values(torrent)
      meths = headers.dup.tap {|ary|ary.shift}
      meths.map {|meth|torrent.send meth}
    end
  end
end