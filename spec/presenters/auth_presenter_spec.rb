require 'rails_helper'

describe AuthPresenter do
  describe '#email' do
    let(:auth) { double('auth', provider: 'asdf', uid: 'asdfasdf') }
    context 'auth has no email info' do
      it 'should create a temp email with uid' do
        auth_presenter = described_class.new(auth)
        allow(auth).to receive_message_chain(:info, :email).and_return(nil)

        expect(auth_presenter.email).to eql "temp-#{auth.uid}@#{auth.provider}.com"
      end
    end
  end
end

