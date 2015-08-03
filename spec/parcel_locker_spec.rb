require 'spec_helper'

describe ParcelLocker do
  it 'has a version number' do
    expect(ParcelLocker::VERSION).not_to be nil
  end

  describe '.all' do
    before :each do
      stub_request(:get, ParcelLocker::API_URL).to_return(status: 200, body: data)
    end

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

    context 'when there is data in response' do
      subject { described_class.all.first }
      let(:data) { File.read('spec/fixtures/one_machine_response.json') }
      it { is_expected.to include('id' => 'ALL992') }
      it do
        is_expected.to include(
          'id', '_links', 'type', 'services', 'payment_type', 'address', 'status',
          'address_str', 'location', 'location_description'
        )
      end
    end
  end
end
