# spec/requests/channels_spec.rb
require 'rails_helper'

def json 
    return ActiveSupport::JSON.decode(response.body)
end

RSpec.describe 'Channel API', type: :request do
  # initialize test data
  let!(:channels) { create_list(:channel, 10) }
  let(:channel_id) { channels.first.id }

  # Test suite for GET /channels
  describe 'GET /channels' do
    # make HTTP get request before each example
    before { get '/channels' }

    it 'returns channels' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /channels/:id
  describe 'GET /channels/:id' do
    before { get "/channels/#{channel_id}" }

    context 'when the record exists' do
      it 'returns the channel' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(channel_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:channel_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Channel/)
      end
    end
  end

  # Test suite for POST /channels
  describe 'POST /channels' do
    # valid payload
    let(:valid_attributes) { { name: 'Discussions'} }

    context 'when the request is valid' do
      before { post '/channels', params: valid_attributes }

      it 'creates a channel' do
        expect(json['name']).to eq('Discussions')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/channels', params: { title: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /channels/:id
  describe 'PUT /channels/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/channels/#{channel_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /channels/:id
  describe 'DELETE /channels/:id' do
    before { delete "/channels/#{channel_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end