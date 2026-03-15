# app/services/strava_client.rb

class StravaClient
  def initialize
    @base_url = ENV.fetch('STRAVA_BASE_URL', 'https://www.strava.com')
    @client_id = ENV['STRAVA_CLIENT_ID']
    @client_secret = ENV['STRAVA_CLIENT_SECRET']
    
    @conn = Faraday.new(url: @base_url) do |f|
      f.request :json
      f.response :json
      f.adapter Faraday.default_adapter
    end
  end

  # Exchange authorization code for access token
  def exchange_token(code)
    response = @conn.post('/oauth/token') do |req|
      req.body = {
        client_id: @client_id,
        client_secret: @client_secret,
        code: code,
        grant_type: 'authorization_code'
      }
    end
    
    response.body
  end

  # Refresh an expired access token
  def refresh_token(refresh_token)
    response = @conn.post('/oauth/token') do |req|
      req.body = {
        client_id: @client_id,
        client_secret: @client_secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }
    end
    
    response.body
  end
end