require 'spec_helper'

module EasyPost
  describe Connection do
    describe '#api_client' do
      subject { described_class.api_client }
      it { is_expected.to be_a_kind_of(Faraday::Connection) }
    end
  end
end
