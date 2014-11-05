require 'spec_helper'

describe BaseballStats::Batting do
  it { should belong_to(:player) }
  it { should have_db_column(:player_id).of_type(:integer) }
  it { should have_db_column(:year).of_type(:integer) }
  it { should have_db_column(:league).of_type(:string) }
  it { should have_db_column(:team).of_type(:string) }
  it { should have_db_column(:g).of_type(:integer) }
  it { should have_db_column(:at_bats).of_type(:integer) }
  it { should have_db_column(:r).of_type(:integer) }
  it { should have_db_column(:hits).of_type(:integer) }
  it { should have_db_column(:doubles).of_type(:integer) }
  it { should have_db_column(:triples).of_type(:integer) }
  it { should have_db_column(:home_runs).of_type(:integer) }
  it { should have_db_column(:runs_batted_in).of_type(:integer) }
  it { should have_db_column(:sb).of_type(:integer) }
  it { should have_db_column(:cs).of_type(:integer) }

  it 'has valid factory' do
    expect(create(:batting)).to be_valid
  end

  let!(:batting) { create(:batting, hits: 3, doubles: 0, triples: 2, home_runs: 1, at_bats: 9) }

  describe '.include_average' do
    it 'calculates batting average for records' do
      battings = BaseballStats::Batting.include_average

      expect(battings.first.average.round(3)).to eq 0.333
    end
  end

  describe '.include_slugging_percentage' do
    it 'calculates slugging percentage for records' do
      battings = BaseballStats::Batting.include_slugging_percentage

      expect(battings.first.slugging_percentage).to eq 1.111
    end
  end

  describe '.for_team' do
    it 'returns only battings for given team' do
      batting1 = create(:batting, team: 'yanks')
      batting2 = create(:batting, team: 'soxs')

      expect(BaseballStats::Batting.for_team('yanks')).to eq [batting1]
    end
  end

  describe '.for_team' do
    it 'returns only battings for given team' do
      batting1 = create(:batting, year: 2009)
      batting2 = create(:batting, year: 2010)

      expect(BaseballStats::Batting.for_year(2009)).to eq [batting1]
    end
  end

  describe '.minimum_at_bats' do
    it 'filters battings who do not meet the minimum number of at_bats' do
      batting1 = create(:batting, at_bats: 400)
      batting2 = create(:batting, at_bats: 405)
      batting3 = create(:batting, at_bats: 300)

      expect(BaseballStats::Batting.minimum_at_bats(400)).to eq [batting1, batting2]
    end
  end

end
