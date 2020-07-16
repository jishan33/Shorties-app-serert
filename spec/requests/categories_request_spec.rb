require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe 'GET #index' do
    before(:example) do
      @first_category = create(:category)
      @last_category = create(:category)
      get '/categories'
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do
      expect(@json_response['categories'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do
      expect(@json_response['categories'][0]).to include({
        'id' => @first_category.id,
        'name' => @first_category.name,
      }) 
    end
  end

end
