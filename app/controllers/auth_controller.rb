class AuthController < ApplicationController
  def index
    strava_auth_url = "https://www.strava.com/oauth/authorize?" + {
      client_id: ENV["STRAVA_CLIENT_ID"],
      redirect_uri: ENV["STRAVA_REDIRECT_URI"],
      response_type: "code",
      scope: "read,activity:read_all,profile:read_all"
    }.to_query

    render inertia: "Auth", props: {
      strava_auth_url: strava_auth_url
    }
  end

  def strava_callback
    if params[:error]
      return redirect_to root_path
    end

    strava_client = StravaClient.new
    token_response = strava_client.exchange_token(params[:code])

    unless token_response["access_token"]
      return redirect_to root_path
    end

    athlete_data = token_response["athlete"]

    user = User.find_or_create_by(strava_id: athlete_data["id"]) do |u|
      u.email = athlete_data["email"]
      u.first_name = athlete_data["firstname"]
      u.last_name = athlete_data["lastname"]
      u.profile_picture = athlete_data["profile"]
    end

    user.update(
      access_token: token_response["access_token"],
      refresh_token: token_response["refresh_token"],
      expires_at: token_response["expires_at"]
    )

    session[:user_id] = user.id

    redirect_to root_path
  rescue => e
    Rails.logger.error("Strava auth error: #{e.message}")
    redirect_to root_path
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path
  end
end
