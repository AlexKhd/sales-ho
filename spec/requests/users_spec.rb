require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns http redirect" do
      get "/users/index"
      expect(response).to have_http_status(:redirect)
    end
  end
end
