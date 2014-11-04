FactoryGirl.define do

  factory :player, class: BaseballStats::Player do
    sequence(:uid) { |n| "player#{n}" }
    birth_year { rand(1980..1985) }
    sequence(:first_name) { |n| "bob#{n}" }
    sequence(:last_name) { |n| "smith#{n}" }
  end

  factory :batting, class: BaseballStats::Batting do
    player
    year            { rand(2010..2014) }
    league          { ['AL', 'NL'][rand(0..1)] }
    team            { rand(200) }
    g               { rand(200) }
    at_bats         { rand(200) }
    r               { rand(200) }
    hits            { rand(200) }
    doubles         { rand(200) }
    triples         { rand(200) }
    home_runs       { rand(200) }
    runs_batted_in  { rand(200) }
    sb              { rand(200) }
    cs              { rand(200) }
  end


end
