require 'rails_helper'

RSpec.describe AuthMailer, type: :mailer do
  let(:user) { build(:user) }
  let(:auth_token) { '12345' }
  subject { described_class.sign_in_mail(user, auth_token) }

  describe 'sign in mail' do
    it 'renders the headers' do
      expect(subject.subject).to eq(t('sign_in_mail.subject'))
      expect(subject.to).to eq([user.email])
      expect(subject.from).to eq(['no-reply@mmdb.me'])
    end

    it 'renders the sign in link in the body' do
      expect(subject.body.encoded).to include(
        "http://localhost:3000/sign_in/?token=#{auth_token}"
      )
    end
  end
end
