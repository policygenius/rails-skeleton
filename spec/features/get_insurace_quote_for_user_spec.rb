require 'rails_helper'
RSpec.describe "GetInsuranceQuoteForUser", type: :feature do

  describe "get a life insurance quote for a user" do
    scenario "get quote" do
      visit '/'
      expect(page).to have_content("insurance quote form")

      fill_in "height", with: "5'5"
      fill_in "weight", with: "120"
      choose("gender_Male")
      click_on("Submit")

      # current url is /quotes
      expect(page).to have_content("Metropolitan Life Insurance Company")
      expect(page).to have_content("$59.76")
    end
  end

end
