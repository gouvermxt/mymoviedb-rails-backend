require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    let(:user_attributes) { { name: 'Foo User', email: 'user@email.com' } }
    let(:created_user) { User.last }
    let(:auth_token) { '12345' }

    let(:post_user) do
      post '/users', params: user_attributes.to_json, headers: base_headers
    end

    before do
      allow(Knock::AuthToken).to receive(:new) { double(token: auth_token) }
    end

    after do
      ActiveJob::Base.queue_adapter.enqueued_jobs = []
      ActiveJob::Base.queue_adapter.performed_jobs = []
    end

    it 'creates a new unconfirmed user' do
      post_user

      expect(response).to have_http_status 201
      expect(json).to include(user_attributes)
      expect(json[:id]).to eq(created_user.id)
      expect(created_user.confirmed_at).to be_nil
    end

    it 'delivers the sign in email' do
      post_user

      expect(ActionMailer::DeliveryJob).to(
        have_been_enqueued
        .on_queue('mailers')
        .at(:no_wait)
        .with(
          'AuthMailer', 'sign_in_mail', 'deliver_now', created_user, auth_token
        )
      )
    end

    context 'when an unconfirmed user with the given email already exists' do
      it 'destroys the previous user and creates a new one with the new data' do
        create(:user, user_attributes.merge(confirmed_at: nil))
        params = { name: 'New name', email: user_attributes[:email] }
        post '/users', params: params.to_json, headers: base_headers

        expect(response).to have_http_status 201
        expect(User.count).to eq 1
        expect(json).to include(params)

        expect(ActionMailer::DeliveryJob).to(
          have_been_enqueued
          .on_queue('mailers')
          .at(:no_wait)
          .with(
            'AuthMailer',
            'sign_in_mail',
            'deliver_now',
            created_user,
            auth_token
          )
        )
      end
    end

    context 'when the user is invalid' do
      let(:user_attributes) { { name: nil, email: 'user@email.com' } }

      it 'just returns an error' do
        post_user

        expect(response).to have_http_status 400
        expect(json[:errors]).to be_present
        expect(created_user).to be_nil
        expect(ActionMailer::DeliveryJob).to_not have_been_enqueued
      end
    end
  end
end
