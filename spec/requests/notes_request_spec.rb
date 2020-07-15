require "rails_helper"

RSpec.describe "Notes", type: :request do
  describe "GET #index" do
    before(:example) do
      @first_note = create(:note)
      @second_note = create(:note)
      get "/notes"
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'JSON response contains the correct number of entries' do 
      expect(@json_response['notes'].count).to eq(2)
    end

    it 'JSON response body contains expected attributes' do 
      expect(@json_response["note"][0]).to include({
        'id' => @first_note.id,
        'title' => @first_note.title,
        'body' =>@first_note.body,
        # 'public_share' =>@first_note.public_share,
        # 'completed' =>@first_note.completed
      })
      end
  end
end
