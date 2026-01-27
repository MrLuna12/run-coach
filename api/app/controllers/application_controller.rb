class ApplicationController < ActionController::API
  private

  def authenticate_user!
    token = extract_token_from_header
    
    unless token
      return render json: { error: 'No token provided' }, status: :unauthorized
    end
    
    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded['user_id'])
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def extract_token_from_header
    authorization_header = request.headers['Authorization']
    return nil unless authorization_header
    
    authorization_header.split(' ').last
  end
end