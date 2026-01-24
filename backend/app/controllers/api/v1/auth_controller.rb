# app/controllers/api/v1/auth_controller.rb

module Api
  module V1
    class AuthController < ApplicationController
      
      def strava_callback
        strava_client = StravaClient.new
        token_response = strava_client.exchange_token(params[:code])
        
        unless token_response['access_token']
          return render json: { error: 'Authentication failed' }, status: :unauthorized
        end
        
        athlete_data = token_response['athlete']
        
        user = User.find_or_create_by(strava_id: athlete_data['id']) do |u|
          u.email = athlete_data['email']
          u.first_name = athlete_data['firstname']
          u.last_name = athlete_data['lastname']
          u.profile_picture = athlete_data['profile']
        end
        
        user.update(
          access_token: token_response['access_token'],
          refresh_token: token_response['refresh_token'],
          expires_at: token_response['expires_at']
        )
        
        jwt = user.generate_jwt
        
        render json: {
          token: jwt,
          user: UserSerializer.new(user).serializable_hash[:data][:attributes]
        }
      rescue => e
        Rails.logger.error("Strava auth error: #{e.message}")
        render json: { error: 'Authentication failed' }, status: :unauthorized
      end

      def me
        render json: { 
          user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] 
        }
      end
    end

    def destroy
      render json: { message: 'Logged out successfully' }
    end
  end
end