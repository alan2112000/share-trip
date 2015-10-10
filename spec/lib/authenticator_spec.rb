require 'rails_helper'
RSpec.describe Authenticator, type: :model do
  describe '#find_user' do
    context 'identity has no user and user is not signin' do
      context 'user did not register account by the email in the the third party acount' do
        let(:user_attributes) { FactoryGirl.attributes_for(:user) }
        let(:identity) { FactoryGirl.create(:identity, user_id: nil)}
        let(:auth) { double('auth_presenter', uid: '1234',
                            provider: 'sadf', email: user_attributes[:email],
                            user_name: 'asdf') }


        it 'should create a user account for auth email and user name' do
          allow(AuthPresenter).to receive(:new).and_return(auth)
          allow(Identity).to receive(:find_for).and_return(identity)
          allow_any_instance_of(Identity).to receive(:user).and_return(nil)


          authenticator = described_class.new(nil, auth)
          user = authenticator.find_user

          expect(user.email).to eql auth.email
        end
      end
    end

    context 'identity has user' do
      let(:user) {FactoryGirl.create(:user)}
      let(:identity) { FactoryGirl.create(:identity, user: user)}
      let(:auth) { double('auth_presenter', email: 'asdfasdfasdf@mail.com') }

      context 'identity of user  is differnet in the user searched by the mail in the auth' do
        it 'should update the identity of the user to current user ' do
          allow(Identity).to receive(:find_for).and_return(identity)
          allow(AuthPresenter).to receive(:new).and_return(auth)
          auth_user = Authenticator.new(user, auth).find_user

          expect(auth_user.email).to eql user.email
        end
      end

      context 'user change the third party email' do
        it 'should change email of the user by auth email' do
          unregitsered_email = 'asdfasdfasdf@mail.com'
          auth_presenter = double('auth_presenter', email: unregitsered_email)

          allow(Identity).to receive(:find_for).and_return(identity)
          allow(AuthPresenter).to receive(:new).and_return(auth_presenter)
          auth_user = Authenticator.new(user, auth).find_user


          expect(auth_user.email).to eql auth_presenter.email
        end
      end
    end
  end
end
