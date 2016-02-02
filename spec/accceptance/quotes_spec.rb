require 'rails_helper'

RSpec.describe "quotes", type: :feature do
  
  describe "when submitted with age and gender" do
    before do
      visit new_quote_path
      fill_in "age", with: 30
      select "M", from: "gender"
      click_button "Get Quotes"
    end
    
    it "should display applicable quotes" do
      expect(page).to have_content "United of Omaha Life Insurance Company: $247.50"
      expect(page).to have_content "Protective Life Insurance Company: $240.46"
    end
    
  end
  
  describe "when submitted without age" do
    it "should display error"
  end
  
  describe "when submitted without gender" do
    
  end
  
end