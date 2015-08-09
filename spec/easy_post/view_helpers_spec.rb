require 'spec_helper'

module EasyPost
  describe ViewHelpers do
    let(:data) { File.read('spec/fixtures/multiple_machines_response.json') }

    before :each do
      allow(EasyPost::Connection).to receive(:get) { JSON.parse(data)['_embedded']['machines'] }
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

      context 'when block is given' do
        subject do
          select_parcel_locker(:select_id) { |lockers| lockers.collect { |l| [l.status, l.id] } }
        end
        it { is_expected.to include '<option value="ALL992">Operating</option>' }
        it { is_expected.to include '<option value="ALW01MP">Operating</option>' }
        it { is_expected.to include '<option value="AND039">Operating</option>' }
        it { is_expected.to include '<option value="AUG01A">Operating</option>' }
        it { is_expected.to include '<option value="AUG848">Not Operating</option>' }
      end
    end
  end
end
