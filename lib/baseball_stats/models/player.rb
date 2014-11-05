
# encoding: UTF-8
require 'csv'

module BaseballStats
  class Player < ActiveRecord::Base

    #- Associations -#

    has_many :battings

    #- Class Methods -#

    def self.bio_file_path
      File.join(APP_ROOT, 'data/Master-small.csv')
    end

    def self.battings_file_path
      File.join(APP_ROOT, 'data/Batting-07-12.csv')
    end

    def self.import_bios_from_csv(file_path=nil)
      file_path     = bio_file_path unless file_path
      total_count   = CSV.read(file_path).length - 1 # subtract header row
      current_count = 0

      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |player_row|
        player = Player.where(uid: player_row[:playerid]).first_or_initialize
        player.birth_year = player_row[:birthyear]
        player.first_name = player_row[:namefirst]
        player.last_name  = player_row[:namelast]
        player.save

        current_count += 1

        p "imported player bio #{current_count} of #{total_count}"
      end
    end

    def self.import_battings_from_csv(file_path=nil)
      file_path     = battings_file_path unless file_path
      total_count   = CSV.read(file_path).length - 1 # subtract header row
      current_count = 0

      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |batting_row|
        player = Player.where(uid: batting_row[:playerid]).first_or_create

        player.battings.create(
          year:             batting_row[:yearid].to_i,
          league:           batting_row[:league],
          team:             batting_row[:teamid],
          g:                batting_row[:g].to_i,
          at_bats:          batting_row[:ab].to_i,
          r:                batting_row[:r].to_i,
          hits:             batting_row[:h].to_i,
          doubles:          batting_row[:'2b'].to_i,
          triples:          batting_row[:'3b'].to_i,
          home_runs:        batting_row[:hr].to_i,
          runs_batted_in:   batting_row[:rbi].to_i,
          sb:               batting_row[:sb].to_i,
          cs:               batting_row[:cs].to_i
        )

        current_count += 1

        p "imported player batting #{current_count} of #{total_count}"
      end
    end

    def self.with_most_improved_batting_average(year)
      previous_year            = year - 1
      averages                 = {}
      most_improved_player_id  = nil
      most_improved_average    = 0.0


      battings = BaseballStats::Batting
                  .include_average
                  .where('at_bats >= ? AND ( year IN (?) )', 200, [year, previous_year])
                  .order(year: :asc)

      battings.each do |batting|
        averages[batting.player_id] ||= []
        averages[batting.player_id] << batting['average']
      end

      averages.each do |player_id, year_averages|
        next unless year_averages[0] && year_averages[1]

        previous_year_avg = year_averages[0]
        current_year_avg  = year_averages[1]

        average_difference = current_year_avg - previous_year_avg

        if average_difference > most_improved_average
          most_improved_player_id = player_id
          most_improved_average = average_difference
        end
      end

      Player.find(most_improved_player_id)

    end

    def self.triple_crown_winner(year, league)
      base_query  = BaseballStats::Batting
                      .minimum_at_bats(400)
                      .for_year(year)
                      .where(league: league)

      highest_batting_avg = base_query.include_average.order('average DESC').first
      most_home_runs      = base_query.order(home_runs: :desc).first
      most_rbis           = base_query.order(runs_batted_in: :desc).first

      ids = [highest_batting_avg, most_home_runs, most_rbis].map(&:player_id)


      winner_exists = ( ids.uniq.size == 1 )

      if winner_exists
        "#{highest_batting_avg.player}"
      else
        "(No winner)"
      end
    end

    #- Instance Methods - #

    def to_s
      "#{first_name} #{last_name}"
    end
  end
end
