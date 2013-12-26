require 'thor'
require 'torrent_search/default_command'
require 'torrent_search/cli'
require 'torrent_search/os'

require "torrent_search/trackers/kick_ass/kick_ass"

require 'torrent_search/views/base'
require 'torrent_search/views/download'
require 'torrent_search/views/menu'
require 'torrent_search/views/search'

require 'torrent_search/services/download'

require 'torrent_search/controllers/download'
require 'torrent_search/controllers/search'

require 'torrent_search/result_table'

require "torrent_search/version"

module TorrentSearch
  # Your code goes here...
end
