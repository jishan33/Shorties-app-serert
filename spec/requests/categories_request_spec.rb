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


  describe 'POST #create' do
    context 'when the category is valid' do
      before(:example) do
        @category_params = attributes_for(:category)
        post '/categories', params: { category: @category_params }
      end

      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the category to the database' do
        expect(Category.last.name).to eq(@category_params[:name])
      end
    end

    context 'when the category is invalid' do
      before(:example) do
        @category_params = attributes_for(:category, :invalid)
        post '/categories', params: { category: @category_params }
        @json_response = JSON.parse(response.body)
      end

      it 'returns status unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(2)
      end

      it 'errors contains the correct message' do
        expect(@json_response['errors'][0]).to eq("Name can't be blank")
      end
    end
  end


end
