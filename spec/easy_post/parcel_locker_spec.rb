require 'spec_helper'

module EasyPost
  describe ParcelLocker do
    before :each do
      allow(EasyPost::Connection).to receive(:api_client) { Faraday.new(EasyPost::DEFAULT_API_ENDPOINT) }
      stub_request(:get, EasyPost::DEFAULT_API_ENDPOINT).to_return(status: 200, body: data)
    end

    describe '.all' do
      context 'and one record is taken' do
        subject { described_class.all.first }
        let(:data) { File.read('spec/fixtures/one_machine_response.json') }

        it { is_expected.to be_a_kind_of(described_class) }
        it { is_expected.to satisfy { |r| !r._links.empty? } }
        it { is_expected.to have_attributes(id: 'ALL992') }
        it { is_expected.to have_attributes(type: 0) }
        it { is_expected.to have_attributes(services: ['parcel']) }
        it { is_expected.to have_attributes(payment_type: 2) }
        it { is_expected.to satisfy { |r| !r.address.empty? } }
        it { is_expected.to have_attributes(status: 'Operating') }
        it { is_expected.to have_attributes(address_str: 'Piłsudskiego 2/4, Aleksandrów Łódzki') }
        it { is_expected.to have_attributes(location: [51.81284, 19.31626]) }
        it { is_expected.to have_attributes(location_description: 'Przy markecie Polomarket') }
      end
    end

    describe '.find' do
      subject { described_class.find(id) }
      let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }

      context 'when there is element with given id' do
        let(:id) { 'ALW01MP' }
        it { is_expected.to be_a_kind_of(described_class) }
        it { is_expected.to have_attributes(id: 'ALW01MP') }
      end

      context 'when there is no element with given id' do
        let(:id) { 'notExistingId' }
        it { is_expected.to be_nil }
      end
    end

    describe '.find_all_by_type' do
      subject { described_class.find_all_by_type(type) }
      let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }

      context 'when there are element with given type' do
        let(:type) { 0 }
        it { is_expected.to have_exactly(2).items }
      end

      context 'when there is no element with given type' do
        let(:type) { 'notExistingType' }
        it { is_expected.to eq [] }
      end
    end
  end
end
