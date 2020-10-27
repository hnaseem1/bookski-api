# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:username) { users.first.username }

  # Test suite for GET /users
  describe 'GET /users' do
    # make HTTP get request before each example
    before { get '/users' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(ActiveSupport::JSON.decode(response.body)).not_to be_empty
      expect(ActiveSupport::JSON.decode(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{username}" }

    context 'when the record exists' do
      it 'returns the users' do
        expect(ActiveSupport::JSON.decode(response.body)).not_to be_empty
        expect(ActiveSupport::JSON.decode(response.body)[0]['username']).to eq(username)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:username) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { username: 'admin101' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(ActiveSupport::JSON.decode(response.body)['username']).to eq('admin101')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { title: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Username can't be blank/)
      end
    end
  end
end