require 'rails_helper'

RSpec.describe QuotesController, type: :controller do
  
  describe "create" do
    describe "when submitted with age and gender" do
      before do
        @test_data = ["i'm valid data"]
        allow(QuoteService).to receive(:get_quote).and_return @test_data
        @params = {age: "30", gender: "F", evil_param: "x"}
        post :create, @params
      end
      
      it "should retrieve quote data from external service" do
        expect(QuoteService).to have_received(:get_quote).with(age: "30", gender: "F")
      end
      
      it "should set instance var to quote data" do
        expect(assigns(:data)).to eq @test_data
      end
    end
    
  end
  
end