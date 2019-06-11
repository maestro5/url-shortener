require 'rails_helper'

RSpec.describe LinkCreator do
  shared_examples 'success' do |value|
    it "returns #{value}" do
      expect(subject.success?).to be value
    end
  end

  shared_examples 'contains an error' do
    it 'includes error message' do
      expect(subject.errors).to include(error_message)
    end
  end

  shared_examples 'does not contain internal link' do
    it 'internal link is nil' do
      expect(subject.internal_link).to be_nil
    end
  end

  shared_examples 'has internal link' do
    it 'not nil' do
      expect(subject.internal_link).not_to be_nil
    end
  end

  shared_examples 'does not create a new link' do
    it 'does not change links amount' do
      expect { subject }.not_to change(LinkList.links, :count)
    end
  end

  shared_examples 'creates a new link' do
    it 'changes amount of links' do
      expect { subject }.to change(LinkList.links, :count).by(1)
    end
  end

  let(:params) { {} }

  subject { described_class.(params) }

  after { LinkList.delete_all }

  context 'with invalid params' do
    context 'without params' do
      let(:error_message) { 'Fill an url and try again.' }

      it_behaves_like 'does not create a new link'
      it_behaves_like 'success', false
      it_behaves_like 'contains an error'
      it_behaves_like 'does not contain internal link'
    end

    context 'when url is not url' do
      let(:params)        { { url: 'hello world' } }
      let(:error_message) { 'This is not an URL.' }

      it_behaves_like 'does not create a new link'
      it_behaves_like 'success', false
      it_behaves_like 'contains an error'
      it_behaves_like 'does not contain internal link'
    end

    context 'when url has already exist' do
      let(:params)        { { url: 'http://www.test_url.com' } }
      let(:internal_link) { 'abc123' }
      let(:existing_link) { { internal_link => params[:url] } }

      before do
        allow_any_instance_of(LinkList).to receive(:links).and_return(existing_link)
      end

      it_behaves_like 'does not create a new link'
      it_behaves_like 'success', true

      it 'has existing internal link' do
        expect(subject.internal_link).to eq internal_link
      end
    end
  end

  context 'with valid params' do
    context 'when url with prefix' do
      let(:params) { { url: 'http://www.test_url.com' } }

      it_behaves_like 'creates a new link'
      it_behaves_like 'success', true
      it_behaves_like 'has internal link'
    end

    context 'when url without a prefix' do
      let(:params)       { { url: 'www.test_url.com' } }
      let(:expected_url) { 'http://www.test_url.com' }

      it_behaves_like 'creates a new link'

      it 'adds scheme for the url' do
        internal_link = subject.internal_link
        expect(LinkList.links[internal_link]).to eq expected_url
      end

      it_behaves_like 'success', true
      it_behaves_like 'has internal link'
    end
  end
end
