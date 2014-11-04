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
    p "Player with most improved batting average from 2009 to 2010 season - #{player.to_s}"
  end

  desc "Slugging percentage for all players on the Oakland A's in 2007"
  task :find_slugging_percentage do
    p "Slugging percentage for all players on the Oakland A's in 2007"
    battings = BaseballStats::Batting.includes(:player).include_slugging_percentage.for_team('OAK').for_year(2007).order('slugging_percentage DESC')
    battings.each { |b| printf "%-20s %s\n", b.player.to_s, b.slugging_percentage }
  end

  task :calculate_stats do
    Rake::Task["app:find_most_improved_batting_average"].invoke
    Rake::Task["app:find_slugging_percentage"].invoke
  end

end
