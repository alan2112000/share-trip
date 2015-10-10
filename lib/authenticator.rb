# This class is responsible for to create user or reasign identity to user
# according the auth give in
class Authenticator
  attr_reader  :oauth_user, :auth_presenter, :identity

  def initialize(user, auth)
    @auth_presenter       = AuthPresenter.new(auth)
    @identity   = Identity.find_for(auth)
    @oauth_user = user || identity.user
  end

  def find_user
    @oauth_user = if user_has_login_by_oauth
                    if user_change_third_party_email?
                      identity.user.email = auth_presenter.email
                      identity.user
                    else
                      oauth_user
                    end
                  else
                    if auth_mail_have_not_be_registered?
                      User.new(name: auth_presenter.user_name,
                               email: auth_presenter.email,
                               password: Devise.friendly_token[0,20])
                    else
                   user_registered_by_auth_email
                    end
                  end

    sync_identity_and_user
    oauth_user
  end


  private

  def user_has_login_by_oauth
    oauth_user
  end

  def auth_mail_have_not_be_registered?
    user_registered_by_auth_email.nil? if auth_presenter.email
  end

  def user_change_third_party_email?
    identity.user
  end

  def user_registered_by_auth_email
    User.find_by(email: auth_presenter.email)
  end


  def sync_identity_and_user
    if user_change_third_party_email
      identity.user = oauth_user
      identity.save!
    end
  end

  def user_change_third_party_email
    identity.user != oauth_user
  end
end
