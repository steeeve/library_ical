require 'rails_helper'

RSpec.describe LoansController, :type => :controller do

  describe "GET index", :vcr do
    pending "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
