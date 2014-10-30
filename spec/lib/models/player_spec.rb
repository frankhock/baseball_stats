require 'spec_helper'

describe BaseballStats::Player do

  describe 'Class Methods' do
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

  end

end
