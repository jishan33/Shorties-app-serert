require "rails_helper"

RSpec.describe "Users", type: :request do

  describe 'POST #create' do
    context 'when the user is valid' do
      before(:example) do
        @user_params = attributes_for(:user)
        post '/sign-up', params: { user: @user_params }, headers: authenticated_header
      end

      it 'returns status created' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the user to the database' do
        expect(User.last.username).to eq(@user_params[:username])
      end
    end

    context 'when the user is invalid' do
      before(:example) do
        @user_params = attributes_for(:user, :invalid_user)
        post '/sign-up', params: { user: @user_params }, 
        headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end
  
      it 'returns status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
  
      it 'returns the correct number of errors' do
        puts "---------------------------"
        puts @json_response['errors']
        expect(@json_response['errors'].count).to eq(2)
      end
  
      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Email can't be blank")
        # expect(@json_response['errors'][1]).to eq("Email can't be blank")
      end
    end
  end

  describe "PUT #update" do
    before(:example) do
      @user = create(:user)
      @updated_name = 'Updated User'
      put "/users/#{@user.id}", params: { user: { username: @updated_name } }, headers: authenticated_header
    end

    it "has a http no content response status" do
      expect(response).to have_http_status(:no_content)
    end

    it "updates user in db" do
      expect(User.find(@user.id).username).to eq(@updated_name)
    end
  end

  describe "DELETE #destroy" do
    before(:example) do
      @user = create(:user)
      delete "/users/#{@user.id}", headers: authenticated_header
    end

    it "has a no_content status" do
      expect(response).to have_http_status(:no_content)
    end

    it "user removed from db" do
    puts "-----------------------------------------------"
    puts User.count
    puts User.last.username
      expect(User.count).to eq(0)
    end

  end
end
