require "test_helper"

class TwitterValidateCredentialsTest < ActiveSupport::TestCase
  setup do
    @user = users(:ben)
  end

  test "should log out" do
    @user.update(
      twitter_access_token: "twitter_access_token",
      twitter_access_secret: "twitter_access_secret",
      twitter_screen_name: "twitter_screen_name",
      twitter_auth_failures: 0
    )

    TwitterValidateCredentials.stub_any_instance :account_credentials_valid?, true do
      User.stub_any_instance :twitter_credentials_valid?, false do
        TwitterValidateCredentials.new.perform

        assert @user.reload.twitter_enabled?

        TwitterValidateCredentials.new.perform
      end
    end

    assert_not @user.reload.twitter_enabled?

    assert_nil @user.twitter_access_token
    assert_nil @user.twitter_access_secret
    assert_nil @user.twitter_screen_name
    assert_nil @user.twitter_auth_failures
  end

end
