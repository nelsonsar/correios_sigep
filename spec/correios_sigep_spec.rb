require 'spec_helper'

describe CorreiosSigep do
  describe '#configure' do
    subject { described_class.configuration }
    before do
      described_class.configure do |config|
        config.user                 = 'user'
        config.password             = 'password'
        config.administrative_code  = '12345'
        config.contract             = '67890'
      end
    end
    it 'configures the correct user' do
      expect(subject.user).to eq 'user'
    end

    it 'configures the correct password' do
      expect(subject.password).to eq 'password'
    end

    it 'configures the correct administrative code' do
      expect(subject.administrative_code).to eq '12345'
    end

    it 'configures the correct contract' do
      expect(subject.contract).to eq '67890'
    end
  end
end
