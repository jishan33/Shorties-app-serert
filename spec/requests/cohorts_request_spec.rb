require "rails_helper"

RSpec.describe "Cohorts", type: :request do
  describe "GET #index" do
    before(:example) do
      @first_cohort = create(:cohort)
      @second_cohort = create(:cohort)
      get "/cohorts"
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON response contains the correct number of entries" do
      expect(@json_response["cohort"].count).to eq(2)
    end

    it "JSON response body contains expected attributes" do
      expect(@json_response["cohort"][0]).to include({
        "id" => @first_cohort.id,
        "name" => @first_cohort.name,
      })
    end
  end

  describe "POST #create" do
    context " when the Cohort is valid" do
      before(:example) do
        @cohort_params = attributes_for(:cohort)
        post "/cohorts", params: { cohort: @cohort_params }, headers: authenticated_header
      end
      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "saves the Cohort to the database" do
        expect(Cohort.last.name).to eq(@cohort_params[:name])
      end
    end

    context "when the Cohort has invalid attributes" do
      before(:example) do
        @cohort_params = attributes_for(:cohort, :invalid)
        post "/cohorts", params: { cohort: @cohort_params }, headers: authenticated_header
        @json_response = JSON.parse(response.body)
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct number of errors" do
        expect(@json_response["errors"].count).to eq(1)
      end

      it "errors contains the correct message" do
        expect(@json_response["errors"][0]).to eq("Name can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "when the param is valid " do
      before(:example) do
        @cohort = create(:cohort)
        @updated_name = "Updated Cohort"
        put "/cohorts/#{@cohort.id}", params: {
                                    cohort: { name: @updated_name },
                                  }, headers: authenticated_header
      end
      it "has a http no content response status" do
        expect(response).to have_http_status(:no_content)
      end

      it "updates the Cohort in the database" do
        expect(Cohort.find(@cohort.id).name).to eq(@updated_name)
      end
    end
  end
end
