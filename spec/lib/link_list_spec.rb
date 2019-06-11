require 'rails_helper'

RSpec.describe LinkList do
  let(:external_link) { 'test_url.com' }
  let(:internal_link) { 'internal_test_link' }

  before { described_class.links[internal_link] = external_link }
  after  { LinkList.delete_all }

  describe '.links' do
    it 'returns all links as a hash' do
      expect(described_class.links).to eq({ internal_link => external_link })
    end
  end

  describe '.find' do
    it 'returns internal link by external' do
      expect(described_class.find(external_link)).to eq internal_link
    end

    it 'returns external link by internal' do
      expect(described_class.find(internal_link)).to eq external_link
    end
  end

  describe '.delete_all' do
    it 'deletes all links from list' do
      expect { described_class.delete_all }.to change(described_class, :links).to({})
    end
  end
end
