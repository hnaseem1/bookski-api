# spec/requests/channel_messages_spec.rb
require 'rails_helper'

def json 
    return ActiveSupport::JSON.decode(response.body)
end

RSpec.describe 'Channel channel_messages API' do
  # Initialize the test data
  let!(:channel) { create(:channel) }
  let!(:user) { create(:user) }
  let!(:channel_messages) { create_list(:channel_message, 20, channel_id: channel.id, user_id: user.id) }
  let(:channel_id) { channel.id }
  let(:id) { channel_messages.first.id }

  # Test suite for GET /channels/:channel_id/channel_messages
  describe 'GET /channels/:channel_id/channel_messages' do
    before { get "/channels/#{channel_id}/channel_messages" }

    context 'when channel exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all channel channel_messages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when channel does not exist' do
      let(:channel_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Channel/)
      end
    end
  end

  # Test suite for GET /channels/:channel_id/channel_messages/:id
  describe 'GET /channels/:channel_id/channel_messages/:id' do
    before { get "/channels/#{channel_id}/channel_messages/#{id}" }

    context 'when channel message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the message' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when channel message does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ChannelMessage/)
      end
    end
  end

  # Test suite for PUT /channels/:channel_id/channel_messages
  describe 'POST /channels/:channel_id/channel_messages' do
    let(:valid_attributes) { {  message: 'Visit Narnia', user_id: user.id} }

    context 'when request attributes are valid' do
      before { post "/channels/#{channel_id}/channel_messages", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/channels/#{channel_id}/channel_messages", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: User must exist/)
      end
    end
  end

  # Test suite for PUT /channels/:channel_id/channel_messages/:id
  describe 'PUT /channels/:channel_id/channel_messages/:id' do
    let(:valid_attributes) {{  message: 'Visit Death Star', user_id: user.id }}

    before { put "/channels/#{channel_id}/channel_messages/#{id}", params: valid_attributes }

    context 'when message exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the message' do
        updated_message = ChannelMessage.find(id)
        expect(updated_message.message).to match(/Visit Death Star/)
      end
    end

    context 'when the message does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ChannelMessage/)
      end
    end
  end

  # Test suite for DELETE /channels/:id
  describe 'DELETE /channels/:id' do
    before { delete "/channels/#{channel_id}/channel_messages/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end