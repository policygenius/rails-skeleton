require 'rails_helper'
RSpec.describe QuotesController, type: :controller do
  describe "POST #create" do
    let(:quote_client) { double(:quote_client, make_api_call: quote) }
    let(:client_info) { {gender: "male"} }
    let(:quote) { double(:quote) }

    before do
      allow(QuoteClient).to receive(:new).with(client_info).and_return(quote_client)
    end

    it "makes a API call and returns insurance policy quotes" do
      post :create, gender: "male"

      expect(assigns(:quotes)).to be quote
    end
  end
end
