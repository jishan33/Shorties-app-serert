module AuthenticationHelpers
  def authenticated_header(user = create(:user))
    token = jwt_token(user)

    { 'Authorization': "Bearer #{token}" }
  end

  def jwt_token(user)
    Knock::AuthToken.new(payload: {sub: user.id}).token
  end  

end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request
end