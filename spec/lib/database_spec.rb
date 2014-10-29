require 'spec_helper'
require 'active_record'

describe BaseballStats::Database do

  describe '.env' do
    let(:env) { BaseballStats::Database.env }

    it 'sets env' do
      expect(env).to eq 'test'
    end
  end

  describe '.config' do
    let(:config) { YAML::load(IO.read('config/database.yml')) }

    it 'sets config' do
      expect(BaseballStats::Database.config).to eq config
    end
  end

end
