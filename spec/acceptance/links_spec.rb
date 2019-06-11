require 'acceptance_helper'

resource 'Link' do
  post '/links.json' do
    parameter :url, 'URL', required: true

    context 'when valid' do
      context 'with scheme' do
        let(:url) { 'http://www.farmdrop.com' }

        example 'Cerates an internal URL' do
          do_request

          expect(status).to eq(200)
          body = JSON.parse(response_body, symbolize_names: true)
          expect(body[:short_url]).not_to be_nil
          expect(body[:url]).to eq url
        end
      end

      context 'without a scheme', document: false do
        let(:url)          { 'www.farmdrop.com' }
        let(:expected_url) { 'http://www.farmdrop.com' }

        example 'Adds a scheme and cerates an internal URL' do
          do_request

          expect(status).to eq(200)
          body = JSON.parse(response_body, symbolize_names: true)
          expect(body[:short_url]).not_to be_nil
          expect(body[:url]).to eq expected_url
        end
      end
    end

    context 'when invalid', document: false do
      let(:url)           { 'test url' }
      let(:error_message) { "This is not an URL." }

      example 'Returns an error' do
        do_request

        expect(status).to eq(422)
        body = JSON.parse(response_body)
        expect(body).to include(error_message)
      end
    end
  end
end
