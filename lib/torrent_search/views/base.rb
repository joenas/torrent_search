module TorrentSearch
  module Views
    class Base
      include Thor::Shell
      include Thor::Actions

      def initialize
      end

      def invalid_option!
        say 'Invalid option', :red
      end

      def invalid_command!
        say 'Invalid command', :red
      end
    end
  end
end