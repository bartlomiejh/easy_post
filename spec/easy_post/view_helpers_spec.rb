require 'spec_helper'

describe EasyPost::ViewHelpers do
  let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }

  before :each do
    stub_request(:get, EasyPost::API_URL).to_return(status: 200, body: data)
  end

  describe '#select_parcel_locker' do
    subject { select_parcel_locker 'select_id', class: 'class', style: 'style' }

    # @review: rspec-html-matchers
    it { is_expected.to include '<select name="select_id" id="select_id" class="class" style="style">' }
    it { is_expected.to include '<option value="ALL992">ALL992</option>' }
    it { is_expected.to include '<option value="ALW01MP">ALW01MP</option>' }
    it { is_expected.to include '<option value="AND039">AND039</option>' }
    it { is_expected.to include '<option value="AUG01A">AUG01A</option>' }
    it { is_expected.to include '<option value="AUG848">AUG848</option>' }
    it { is_expected.to include '</select>' }
  end
end
