require "rails_helper"

RSpec.describe "Notes", type: :request do
  describe "GET #index" do
    before(:example) do
      @user = create(:user)
      @first_note = create(:note, user: @user)
      @second_note = create(:note, user: @user)

      get "/notes", headers: authenticated_header(@user)
      @json_response = JSON.parse(response.body)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "JSON response contains the correct number of entries " do
      expect(@json_response["notes"].count).to eq(2)
    end

    it "JSON response body contains expected attributes" do
      expect(@json_response["notes"][0]).to include(
        "body" => @first_note.body,
        "completed" => @first_note.completed,
        "created_at" => @first_note.created_at.strftime("%Y-%m-%dT%R:%S.%LZ"),
        "id" => @first_note.id,
        "public_share" => @first_note.public_share,
        "title" => @first_note.title,
        "updated_at" => @first_note.updated_at.strftime("%Y-%m-%dT%R:%S.%LZ"),
        "user_id" => @first_note.user_id,
        "categories" => @first_note.categories,
      )
    end
  end

  describe "POST #create" do
    context "when the note is valid" do
      before(:example) do
        @user = create(:user)
        @category = create(:category)
        category_id = @category.id
        @note_params = attributes_for(:note, category_ids: [category_id].to_s)

        post "/notes", params: { note: @note_params },
                       headers: authenticated_header(@user)
      end

      it "returns http created" do
        expect(response).to have_http_status(201)
      end

      it "save the Note to the database" do
        expect(Note.last.title).to eq(@note_params[:title])
      end
    end

    context "when the Note has invalid attributes" do
      before(:example) do
        @user = create(:user)
        @category = create(:category)
        category_id = @category.id
        @note_params = attributes_for(:note, :invalid, category_ids: [category_id].to_s)
        post "/notes", params: { note: @note_params }, headers: authenticated_header(@user)
        @json_response = JSON.parse(response.body)
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      it "returns the correct number of errors" do
        expect(@json_response["errors"].count).to eq(2)
      end

      it "errors contains the correct message" do
        expect(@json_response["errors"][0]).to eq("Title can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "when the params are valid" do
      before(:example) do
        @note = create(:note)
        @category = create(:category)
        @updated_body = "Updated body"

        put "/notes/#{@note.id}", params: { note: { body: @updated_body, categories_attributes: [@category.id, @category.name] } }, headers: authenticated_header
      end

      it "has a http no content response status" do
        expect(response).to have_http_status(200)
      end

      it "updates the note in the database" do
        expect(Note.find(@note.id).body).to eq(@updated_body)
      end
    end

    context "when the params is invalid" do
      before(:example) do
        @category = create(:category)
        @note = create(:note)
        put "/notes/#{@note.id}", params: { note: { title: nil, categories_attributes: [@category.id, @category.name] } }, headers: authenticated_header
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

  context "DELETE #destroy" do
    before(:example) do
      @note = create(:note)
      delete "/notes/#{@note.id}", headers: authenticated_header
    end

    it "has a http no content response status" do
      expect(response).to have_http_status(:no_content)
    end

    it "has the correct number of trails" do
      expect(Note.count).to eq(0)
    end
  end
end
