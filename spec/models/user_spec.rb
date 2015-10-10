require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email)}
  it { should have_many(:trips) }
  it { should have_many(:locations).through(:trips) }


  describe '.from_omniauth' do
    let(:auth) do
      # auth = double(:auth)
      # auth.stub(:
    end

    context 'user already sign in' do
      it 'return user diretly' do
        current_user = create(:user)


      end
    end

    context 'user never register before' do
      it 'user should be new record' do
        expect(user.persisted?).to eql false
      end

      context 'user never use the email in the auth to sign up before' do
        it 'create a new account for the user' do

        end
      end

      context 'no email in the auth information' do
        it 'should create a prefix uid for the user email' do

        end
      end
    end

    it 'should return a user' do

    end


    it 'should the identity should have user' do

    end
  end
end

