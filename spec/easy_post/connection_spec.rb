require 'spec_helper'

module EasyPost
  describe Connection do
    describe '#api_client' do
      subject { described_class.api_client }
      it { is_expected.to be_a_kind_of(Faraday::Connection) }
    end

    describe '#get' do
      context 'when response is not cached' do
        before :each do
          allow(EasyPost::Connection).to receive(:api_client) { Faraday.new(EasyPost::DEFAULT_API_ENDPOINT) }
          stub_request(:get, EasyPost::DEFAULT_API_ENDPOINT).to_return(status: 200, body: data)
        end
        context 'when data schema is invalid' do
          subject { -> { described_class.get } }
          context 'and there is no _embedded key' do
            let(:data) { '{"not_embedded": {"machines": [{"id": "1"}]}}' }
            it { is_expected.to raise_error(JSON::Schema::ValidationError) }
          end

          context 'and there is no machines key under _embedded key' do
            let(:data) { '{"_embedded": {"not_machines": [{"id": "1"}]}}' }
            it { is_expected.to raise_error(JSON::Schema::ValidationError) }
          end
        end

        context 'when data schema is valid' do
          subject { described_class.get }
          let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }
          it { is_expected.to have_exactly(5).items }
        end
      end

      context 'when response is cached' do
        let(:data) { File.read('spec/fixtures/one_machine_response.json') }
        it 'only first request hits API' do
          stub = stub_request(:get, EasyPost::DEFAULT_API_ENDPOINT).to_return(status: 200, body: data)

          described_class.get
          described_class.get
          expect(stub).to have_been_made.once
        end
      end
    end
  end
end
