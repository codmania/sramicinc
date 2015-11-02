require 'rails_helper'

RSpec.describe "WatchLists", type: :request do
  describe "GET /watch_lists" do
    it "works! (now write some real specs)" do
      get watch_lists_path
      expect(response).to have_http_status(200)
    end
  end
end
