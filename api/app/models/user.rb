class User < ApplicationRecord
  validates :strava_id, presence: true, uniqueness: true

  def generate_jwt
    payload = { user_id: id, exp: 24.hours.from_now.to_i }
    JsonWebToken.encode(payload)
  end
end
