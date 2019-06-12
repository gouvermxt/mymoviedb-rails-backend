require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('foo@email.com').for(:email) }
    it do
      is_expected.to_not(
        allow_values('fooemail', 'foo@email', '.com').for(:email)
      )
    end
  end
end
