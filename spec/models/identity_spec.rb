require 'rails_helper'

RSpec.describe Identity, type: :model do

  describe '.find_for' do
    let(:auth) { double('auth', uid: 'asdfasdf', provider: 'whatever') }
    context "auth never exists Before" do
      it 'should create a new identity' do
        expect { Identity.find_for(auth)}.to change{Identity.all.size}.from(0).to(1)
      end

      context "auth have been created before " do
        it 'should find the identitty without crete' do
          identity = Identity.create(uid: auth.uid, provider: auth.provider)
          expect(described_class.find_for(auth)).to eql identity
        end
      end

    end

  end

end
