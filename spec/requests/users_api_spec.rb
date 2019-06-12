require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    let(:user_attributes) { { name: 'Foo User', email: 'user@email.com' } }
    let(:created_user) { User.last }
    let(:auth_token) { '12345' }

    before do
      allow(Knock::AuthToken).to receive(:new) { double(token: auth_token) }
      post '/users', params: user_attributes.to_json, headers: base_headers
    end

    after do
      ActiveJob::Base.queue_adapter.enqueued_jobs = []
      ActiveJob::Base.queue_adapter.performed_jobs = []
    end

    it 'creates a new user' do
      expect(response).to have_http_status 201
      expect(json).to include(user_attributes)
      expect(json[:id]).to eq(created_user.id)
    end

    it 'delivers the sign in email' do
      expect(ActionMailer::DeliveryJob).to(
        have_been_enqueued
        .on_queue('mailers')
        .at(:no_wait)
        .with(
          'AuthMailer', 'sign_in_mail', 'deliver_now', created_user, auth_token
        )
      )
    end

    context 'when the user is invalid' do
      let(:user_attributes) { { name: nil, email: 'user@email.com' } }

      it 'just returns an error' do
        expect(response).to have_http_status 400
        expect(json[:errors]).to be_present
        expect(created_user).to be_nil
        expect(ActionMailer::DeliveryJob).to_not have_been_enqueued
      end
    end
  end
end
