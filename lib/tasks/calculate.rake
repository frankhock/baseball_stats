require 'baseball_stats'

namespace :app do

  desc "Import CSV Files"
  task :import_csv_data do
    Rake::Task['db:reset'].invoke
    BaseballStats::Player.import_bios_from_csv
    BaseballStats::Player.import_battings_from_csv
  end

  desc "Find most improved batting average from 2009-2010 season"
  task :find_most_improved_batting_average do
    player = BaseballStats::Player.with_most_improved_batting_average(2010)
    puts "\n"
    p "Player with most improved batting average from 2009 to 2010 season"
    puts "#{player} \n\n"
  end

  desc "Slugging percentage for all players on the Oakland A's in 2007"
  task :find_slugging_percentage do
    p "Slugging percentage for all players on the Oakland A's in 2007"
    battings = BaseballStats::Batting
                .includes(:player)
                .include_slugging_percentage
                .for_team('OAK')
                .for_year(2007)
                .where{ at_bats > 0 }
                .order('slugging_percentage DESC')

    battings.each { |b| printf "%-20s %s\n", b.player.to_s, b.slugging_percentage }
    puts "\n"
  end

  desc "Find Triple Crown Winners"
  task :find_triple_crown_winners do
    text = "Triple Crown Winner - "

    player = BaseballStats::Player.triple_crown_winner(2011, 'AL')
    p "2011 AL " + text + player

    player = BaseballStats::Player.triple_crown_winner(2011, 'NL')
    p "2011 NL " + text + player

    player = BaseballStats::Player.triple_crown_winner(2012, 'AL')
    p "2012 AL " + text + player

    player = BaseballStats::Player.triple_crown_winner(2012, 'NL')
    p "2012 NL " + text + player
  end

  task :calculate_stats do
    Rake::Task["app:find_most_improved_batting_average"].invoke
    Rake::Task["app:find_slugging_percentage"].invoke
    Rake::Task["app:find_triple_crown_winners"].invoke
  end

end
