require 'rails_helper'

RSpec.describe 'Current User API', type: :request do
  let(:auth) { sign_in! }

  describe 'GET /current_user' do
    it 'returns the current user given the token' do
      get '/current_user', headers: auth_headers(auth)
      user = auth[:user].attributes.slice('id', 'name', 'email')

      expect(response).to have_http_status 200
      expect(json).to eq(user.symbolize_keys)
    end
  end

  context 'when the token is invalid' do
    it 'unauthorizes the request' do
      auth[:token] = 'invalid-token'
      get '/current_user', headers: auth_headers(auth)

      expect(response).to have_http_status 401
      expect(response.body).to be_empty
    end
  end

  context 'when it is the first access' do
    let(:unconfirmed_user) { create(:user, confirmed_at: nil) }
    let(:auth) { sign_in!(unconfirmed_user) }

    it 'defines the user as confirmed' do
      start_time = Time.current
      get '/current_user', headers: auth_headers(auth)
      end_time = Time.current
      unconfirmed_user.reload

      expect(unconfirmed_user.confirmed_at).to be_between(start_time, end_time)
    end
  end
end