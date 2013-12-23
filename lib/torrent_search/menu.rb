module TorrentSearch

  ACTIONS = {
    d: :download,
    s: :search,
    q: :quit
  }

  class Menu < SimpleDelegator
    def initialize(view, search_result)
      @view = view
      @search_result = search_result
      super @view
    end

    def display
      say_status "\n[Results]", '', :green
      if results?
        print_table result_table
      else
        say 'Nothing found'
      end
      say_status "\n[Actions]", actions, :blue
      choose_action!
    end

  private
    def results?
      @search_result.any?
    end

    def result_table
      ResultTable.new(@search_result)
    end

    def available_actions
      ACTIONS.dup.tap {|hash| hash.delete(:d) unless results? }
    end

    def actions
      available_actions.map {|hash| hash.join(": ")}.join("\t")
    end

    def choose_action!
      chosen = ask("Choose:").to_sym
      send available_actions.fetch(chosen, :invalid_command)
    end

    def invalid_command
      say 'Invalid command', :red
      choose_action!
    end

    def quit
      CLI::quit
    end

    def search
      super ask("Search for:").split
    end

    def download
      index = ask("Torrent (0-#{search_result_range.max}):")
      unless index.match(/\A\d+\z/) && is_in_search_result?(index)
        say 'Invalid option', :red
        download
      end
      torrent = @search_result[index.to_i]
      Download.new(@view, torrent).perform
    end

    def is_in_search_result?(index)
      search_result_range.member?(index.to_i)
    end

    def search_result_range
      @range ||= Range.new(0, @search_result.length, true)
    end
  end
end