class UserSerializer
  include JSONAPI::Serializer
  
  attributes :strava_id, :email, :first_name, :last_name, :profile_picture
end