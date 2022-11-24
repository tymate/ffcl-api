# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType, type: :request do
  let(:query) { 'invitationClub' }
  let(:user) { Fabricate(:user) }
  let(:club) { Fabricate(:club, admin: user) }
  let(:mailer) { instance_double(ActionMailer::MessageDelivery) }

  let(:variables) do
    {
      input: {
        clubId: club.to_gid(expires_in: nil).to_s,
        email: user.email
      }
    }
  end

  describe 'when authenticated' do
    it_behaves_like 'with standard user' do
      before do
        allow(UserMailer).to receive(:invitation_club).and_return(mailer)
        allow(mailer).to receive(:deliver_later).and_return(nil)
        do_graphql_request
      end

      it 'send a user requested access mail to the office contact' do
        expect(errors).to be_blank
        expect(mailer).to have_received(:deliver_later).once
      end
    end
  end
end
