require 'spec_helper'

describe BaseballStats::Player do
  it { should have_many(:battings) }
  it { should have_db_column(:uid).of_type(:string) }
  it { should have_db_column(:birth_year).of_type(:integer) }
  it { should have_db_column(:first_name).of_type(:string) }
  it { should have_db_column(:last_name).of_type(:string) }

  it 'has valid factory' do
    expect(create(:player)).to be_valid
  end

  context 'Class Methods' do
    let(:csv_file) { File.expand_path('spec/fixtures/bios.csv') }

    subject { BaseballStats::Player }

    describe '.bio_file_path' do
      it 'sets default file_path' do
        expect(subject.bio_file_path).to eq File.join(BaseballStats::APP_ROOT, 'data/Master-small.csv')
      end
    end

    describe '.import_bios_from_csv' do
      it "imports players' bios" do
        expect{subject.import_bios_from_csv(csv_file)}.to change{BaseballStats::Player.count}.to 5
      end
    end

    describe '.with_most_improved_batting_average' do
      it 'returns player with most improved batting average' do
        batting1_2009 = create(:batting, hits: 205, at_bats: 500, year: 2009)
        batting1_2010 = create(:batting, hits: 200, at_bats: 200, year: 2010, player: batting1_2009.player)

        batting2_2009 = create(:batting, hits: 200, at_bats: 1000, year: 2009)
        batting2_2010 = create(:batting, hits: 200, at_bats: 300, year: 2010, player: batting2_2009.player)

        expect(subject.with_most_improved_batting_average(2010)).to eq batting1_2010.player
      end
    end

    describe '.triple_crown_winner' do
        let!(:batting1)  { create(:batting, hits: 200, at_bats: 500, year: 2009, league: 'AL') }
        let!(:batting2)  { create(:batting, home_runs: 200, year: 2009, at_bats: 500, league: 'AL', player: batting1.player) }
        let!(:batting3)  { create(:batting, runs_batted_in: 200, year: 2009, at_bats: 500, league: 'AL', player: batting1.player) }

      context 'when triple crown winner exists' do
        it 'returns player name' do
          expect(subject.triple_crown_winner(2009, 'AL')).to eq "#{batting1.player}"
        end
      end

      context 'when triple crown winner does not exist' do
        it 'returns no winner' do
          batting4 = create(:batting, home_runs: 300, year: 2009, at_bats: 500, league: 'AL')

          expect(subject.triple_crown_winner(2009, 'AL')).to eq "(No winner)"
        end
      end
    end

  end

end
