require 'spec_helper'

module EasyPost
  describe ViewHelpers do
    let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }

    before :each do
      allow(EasyPost).to receive(:api_client) { Faraday.new(EasyPost::DEFAULT_API_ENDPOINT) }
      stub_request(:get, EasyPost::DEFAULT_API_ENDPOINT).to_return(status: 200, body: data)
    end

    describe '#select_parcel_locker' do
      subject { select_parcel_locker :select_id }
      # @review: rspec-html-matchers
      it { is_expected.to include '<option value="ALL992">ALL992</option>' }
      it { is_expected.to include '<option value="ALW01MP">ALW01MP</option>' }
      it { is_expected.to include '<option value="AND039">AND039</option>' }
      it { is_expected.to include '<option value="AUG01A">AUG01A</option>' }
      it { is_expected.to include '<option value="AUG848">AUG848</option>' }

      context 'when html_options are specified' do
        subject { select_parcel_locker :select_id, class: 'my-class', style: 'color: red;' }
        it { is_expected.to include '<select name="select_id" id="select_id"' }
        it { is_expected.to include 'class="my-class" style="color: red;">' }
        it { is_expected.to include '</select>' }
      end

      context 'when machine type is specified' do
        subject { select_parcel_locker :select_id, {}, 0 }
        it { is_expected.to include '<option value="ALL992">ALL992</option>' }
        it { is_expected.to include '<option value="ALW01MP">ALW01MP</option>' }
        it { is_expected.not_to include '<option value="AND039">AND039</option>' }
        it { is_expected.not_to include '<option value="AUG01A">AUG01A</option>' }
        it { is_expected.not_to include '<option value="AUG848">AUG848</option>' }
      end
    end
  end
end
