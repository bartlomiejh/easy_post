require 'spec_helper'

describe ParcelLocker do
  it 'has a version number' do
    expect(ParcelLocker::VERSION).not_to be nil
  end

  describe '.all' do
    let(:valid_data) { File.read('spec/fixtures/valid_with_one_machine.json') }
    before do
      stub_request(:get, ParcelLocker::API_URL).to_return(status: 200, body: valid_data)
    end
    subject { described_class.all.count }
    it { is_expected.to eq 1 }
  end
end
