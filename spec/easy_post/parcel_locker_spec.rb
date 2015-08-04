require 'spec_helper'

describe EasyPost::ParcelLocker do
  before :each do
    stub_request(:get, EasyPost::API_URL).to_return(status: 200, body: data)
  end

  describe '.all' do
    context 'when data schema' do
      subject { -> { described_class.all } }

      context 'is valid' do
        let(:data) { '{"_embedded": {"machines": [{"id": "1"}]}}' }
        it { is_expected.not_to raise_error(JSON::Schema::ValidationError) }
      end

      context 'is invalid' do
        context 'and there is no _embedded key' do
          let(:data) { '{"not_embedded": {"machines": [{"id": "1"}]}}' }
          it { is_expected.to raise_error(JSON::Schema::ValidationError) }
        end

        context 'and there is no machines key under _embedded' do
          let(:data) { '{"_embedded": {"not_machines": [{"id": "1"}]}}' }
          it { is_expected.to raise_error(JSON::Schema::ValidationError) }
        end
      end
    end

    context 'when data is parsed' do
      subject { described_class.all }
      let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }
      it { is_expected.to have_exactly(5).items }

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
end
