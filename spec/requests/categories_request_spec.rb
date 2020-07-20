require "rails_helper"

RSpec.describe "Categories", type: :request do
  describe "GET #index" do
    before(:example) do
      @first_category = create(:category)
      @last_category = create(:category)
      get "/categories"
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON response contains the correct number of entries" do
      expect(@json_response.count).to eq(2)
    end

    it "JSON response body contains expected attributes" do
      expect(@json_response[0]).to include({
        "id" => @first_category.id,
        "name" => @first_category.name,
      })
    end
  end

  describe "POST #create" do
    context "when the category is valid" do
      before(:example) do
        @category_params = [attributes_for(:category)]
        post "/categories", params: { categories: @category_params }
      end

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "saves the category to the database" do
        expect(Category.last.name).to eq(@category_params.last[:name])
      end
    end

  end

  describe "PUT #update" do
    context "when the params are valid" do
      before(:example) do
        @category = create(:category)
        @updated_name = "Updated category name"
        put "/categories/#{@category.id}", params: { category: { name: @updated_name } }
      end

      it "has a http no content response status" do
        expect(response).to have_http_status(:no_content)
      end

      it "updates the category in the database" do
        expect(Category.find(@category.id).name).to eq(@updated_name)
      end
    end

    context "when the params are invalid" do
      before(:example) do
        @category = create(:category)
        put "/categories/#{@category.id}", params: { category: { name: nil } }
        @json_response = JSON.parse(response.body)
      end

      it "returns a unprocessable entity response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "has the correct number of errors" do
        expect(@json_response["errors"].count).to eq(2)
      end
    end
  end
end
