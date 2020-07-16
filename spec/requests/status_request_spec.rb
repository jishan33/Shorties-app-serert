require "rails_helper"

RSpec.describe "Statuses", type: :request do
  describe "GET #index" do
    before(:example) do
      user = create(:user)
      @token = jwt_token(user)
      get "/status", headers: authenticated_header(user)

      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON response contains the correct jwt" do
      expect(@json_response["jwt"]).to eq(@token)
    end
  end

  describe "GET #user" do
    before(:example) do
      @user = create(:user)
      get "/status/user", headers: authenticated_header(@user)
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON response contains the current user email" do
      expect(@json_response["user"]).to eq(@user.email)
    end
  end
end
