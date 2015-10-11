  class AuthPresenter
    attr_reader :auth

    delegate :provider, :uid, to: :auth

    def initialize(auth)
      @auth = auth
    end

    def email
      auth.info.email || temp_email
    end

    def user_name
      auth.info.name
    end

    def email_is_verified?
      auth.info.email && (auth.info.verified || auth.info.verified_email)
    end

    private

    def temp_email
      "temp-#{uid}@#{provider}.com"
    end
  end

