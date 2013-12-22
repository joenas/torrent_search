module TorrentSearch

  OPTIONS = {
    q: :quit,
    s: :search_again
  }

  class Menu < SimpleDelegator
    def initialize(view, search_result)
      @view = view
      @search_result = search_result
      super @view
    end

    def display
      print_table ResultTable.new(@search_result)
      print_in_columns actions
    end

  private
    def actions
      ['Actions', *OPTIONS.values]
    end

    def choose_action(search_result)
      selected = ask("Choose torrent (0 to search again):").to_i
      if selected != 0
        download search_result[selected-1]
      else
        search_again
      end
    end

    def ask(question)
      @view.ask question
    end

    def search_again
      perform ask("Search for:").split
    end

    def download(torrent)
      Download.new(@view, torrent).perform
    end
  end
end