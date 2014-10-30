require 'csv'

module BaseballStats
  class Player < ActiveRecord::Base

    def self.bio_file_path
      File.join(APP_ROOT, 'data/Master-small.csv')
    end

    def self.import_bios_from_csv(file_path=nil)
      file_path     = bio_file_path unless file_path
      total_count   = CSV.read(file_path).length - 1 # subtract header row
      current_count = 0

      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |player_row|
        player = Player.where(player_id: player_row[:playerid]).first_or_initialize
        player.birth_year = player_row[:birthyear]
        player.first_name = player_row[:firstname]
        player.last_name  = player_row[:last_name]
        player.save

        current_count += 1

        p "imported player bio #{current_count} of #{total_count}"
      end

    end

  end
end
