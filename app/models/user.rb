class User < ApplicationRecord
  validates :strava_id, presence: true, uniqueness: true
end
