require 'spec_helper'

module EasyPost
  describe Configuration do
    describe '#api_endpoint' do
      context 'when is not set' do
        subject do
          described_class.new.api_endpoint
        end
        it { is_expected.to eq 'https://api-pl.easypack24.net/v4/machines?type=0' }
      end

      context 'when is set' do
        subject do
          c = described_class.new
          c.api_endpoint = 'https://new.api.com'
          c.api_endpoint
        end
        it { is_expected.to eq 'https://new.api.com' }
      end
    end
  end
end
