require 'spec_helper'

describe ParcelLocker do
  it 'has a version number' do
    expect(ParcelLocker::VERSION).not_to be nil
  end

  describe '.all' do
    subject { described_class.all.count }
    it { is_expected.to eq 1329 }
  end
end
