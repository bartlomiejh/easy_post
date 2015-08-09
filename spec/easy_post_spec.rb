require 'spec_helper'

describe EasyPost do
  it 'has a version number' do
    expect(EasyPost::VERSION).not_to be nil
  end

  describe '#configure' do
    context 'when block given' do
      subject do
        described_class.configure do |config|
          config.api_endpoint = 'http://enpoint.from.block/'
        end
        described_class.configuration
      end
      it { is_expected.to have_attributes(api_endpoint: 'http://enpoint.from.block/') }
    end
  end

end
