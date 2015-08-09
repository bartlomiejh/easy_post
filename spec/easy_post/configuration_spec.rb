require 'spec_helper'

module EasyPost
  describe Configuration do
    describe '.api_endpoint' do
      context 'when is not set' do
        subject { described_class.new.api_endpoint }
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

    describe '.cache_dir' do
      context 'when is not set' do
        subject { described_class.new.cache_dir }
        it { is_expected.to eq File.join(ENV['TMPDIR'] || '/tmp', 'cache') }
      end

      context 'when is set' do
        subject do
          c = described_class.new
          c.cache_dir = '/new/cache/dir'
          c.cache_dir
        end
        it { is_expected.to eq '/new/cache/dir' }
      end
    end

    describe '.cache_expires_s' do
      context 'when is not set' do
        subject { described_class.new.cache_expires_s }
        it { is_expected.to eq 3600 }
      end

      context 'when is set' do
        subject do
          c = described_class.new
          c.cache_expires_s = 10
          c.cache_expires_s
        end
        it { is_expected.to eq 10 }
      end
    end
  end
end
