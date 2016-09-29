module OmniauthMacros
  def mock_auth
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '1234567',
      info: {
        email: 'facebook@email.com',
        name: 'Joe Bloggs',
        # image: 'http://graph.facebook.com/1234567/picture?type=square',
        verified: true
      },
      credentials: {
        token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
        # expires_at: 1321747205, # when the access token expires (it always will)
        # expires: true # this will always be true
      }
    })

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: "twitter",
      uid: "123456",
      info: {
        nickname: "johnqpublic",
        name: "John Q Public",
        location: "Anytown, USA",
        image: "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
        description: "a very normal guy.",
        urls: {
          Website: nil,
          Twitter: "https://twitter.com/johnqpublic"
        }
      },
      credentials: {
        token: "a1b2c3d4...", # The OAuth 2.0 access token
        secret: "abcdef1234"
      }
    })
  end
end