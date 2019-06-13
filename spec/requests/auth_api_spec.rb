require 'rails_helper'

RSpec.describe 'Auth API', type: :request do
  let(:user) { create(:user) }
  let(:email_param) { user.email }
  let(:params) { { email: email_param } }
  let(:auth_token) { '12345' }
  let(:post_auth) do
    post '/auth', params: params.to_json, headers: base_headers
  end

  describe 'GET /auth' do
    before do
      allow(Knock::AuthToken).to receive(:new) { double(token: auth_token) }
    end

    after do
      ActiveJob::Base.queue_adapter.enqueued_jobs = []
      ActiveJob::Base.queue_adapter.performed_jobs = []
    end

    it 'sends the sign in link to the email of the user' do
      post_auth

      expect(response).to have_http_status 201
      expect(ActionMailer::DeliveryJob).to(
        have_been_enqueued
        .on_queue('mailers')
        .at(:no_wait)
        .with(
          'AuthMailer', 'sign_in_mail', 'deliver_now', user, auth_token
        )
      )
    end

    context 'when the user does not exist' do
      let(:email_param) { 'email@dont.exists' }

      it 'just returns an error' do
        post_auth

        expect(response).to have_http_status 404
        expect(json[:errors]).to be_present
        expect(ActionMailer::DeliveryJob).to_not have_been_enqueued
      end
    end
  end
end
