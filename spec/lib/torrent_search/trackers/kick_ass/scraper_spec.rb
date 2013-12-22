require 'spec_helper'

describe TorrentSearch::Trackers::KickAss::Scraper do
  Given(:search_terms){['ubuntu', '12']}
  subject{described_class.new(search_terms)}

  describe '#search', :vcr do
  	Given(:torrent){result.first}
    When(:result){subject.search}

    Then{result.count.should eq 10}
    And{torrent.name.should eq "ubuntu 12.04.3 [64 bit]"}
    And{torrent.size.should eq "708 MB"}
    And{torrent.seeders.should eq "824"}
    And{torrent.leechers.should eq "20"}
    And{torrent.href.should eq "http://torcache.net/torrent/962FCFA03B061506E2E133AC4B5C8BC5151C4C6A.torrent"}
    And{torrent.filename.should eq "[kickass.to]ubuntu.12.04.3.64.bit"}
  end
end