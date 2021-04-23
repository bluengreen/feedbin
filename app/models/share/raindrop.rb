class Share::Raindrop < Share::Service
  URL = "https://raindrop.io"
  API_URL = "https://api.raindrop.io"

  # 1. raindrop = Raindrop.new
  # 2. client = raindrop.request_token
  # 3. session[:raindrop_token] = client.token; session[:raindrop_secret] = client.secret
  # 4. redirect_to client.authorize_url
  # 5. raindrop = Raindrop.new
  # 6. access_token = raindrop.request_access(session[:raindrop_token], session[:raindrop_secret], params[:oauth_verifier])
  # 7. save access_token.token and access_token.secret in the database

  def initialize(klass = nil)
    @klass = klass
    if @klass.present?
      @client = OAuth2::AccessToken.from_hash consumer, @klass.oauth2_token
    end
  end

  def consumer
    OAuth2::Client.new(ENV["RAINDROP_KEY"], ENV["RAINDROP_SECRET"], {token_url: "/oauth/access_token", site: URL})
  end

  def request_token
    consumer.auth_code.authorize_url(redirect_uri: redirect_uri)
  end

  def request_access(code)
    token = consumer.auth_code.get_token(code, redirect_uri: redirect_uri, headers: {"Content-Type" => "application/json"})
  end

  def redirect_uri
    Rails.application.routes.url_helpers.oauth2_response_supported_sharing_service_url("raindrop", host: ENV["PUSH_URL"])
  end

  def response_valid?(session, params)
    params[:oauth_verifier].present?
  end

  def user_info
    result = @client.get("#{API_URL}/user/info")
    JSON.load(result.body)
  end

  def add(params, entry)
    if @client.expired?
      @client.refresh!
      @klass.update(oauth2_token: @client.to_hash.to_json)
    end

    body = {
      title: entry.title,
      link: entry.fully_qualified_url,
      pleaseParse: {}
    }

    response = HTTP.auth("Bearer #{@client.token}").post("#{API_URL}/rest/v1/raindrop", json: body)

    response.status.code
  end

  def share(params)
    authenticated_share(@klass, params)
  end

  def after_activate
  end
end
