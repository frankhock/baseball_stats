module BaseballStats
  class Batting < ActiveRecord::Base
    self.table_name = 'battings'

    #- Associations -#

    belongs_to :player

    #- Scopes -#

    scope :include_average, -> { select('*, ((hits * 1.0) / at_bats) AS average') }
    scope :include_slugging_percentage, -> { select('*, round((((hits - doubles - triples - home_runs) + (2 * doubles) + (3 * triples) + (4 * home_runs)) / (at_bats * 1.0)), 3) AS slugging_percentage') }
    scope :for_team, -> (team) { where(team: team) }
    scope :for_year, -> (year) { where(year: year) }

  end
end
