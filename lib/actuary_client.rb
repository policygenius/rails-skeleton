class ActuaryClient
  BASE_URL = 'actuary-development.policygenius.com/policies?date_of_birth=1980-01-21&gender=male&health_profile[currently_uses_tobacco]=false&health_profile[height_feet]=5&health_profile[height_inches]=8&health_profile[history_of_tobacco_use]=false&health_profile[weight]=180&state_code=TX'
  def self.fetch_policies(term_in_years:, coverage_amount:)
    Rails.cache.fetch([term_in_years, coverage_amount]) do
      JSON
        .parse(RestClient.get("#{BASE_URL}&policy_profile[coverage_amount]=#{coverage_amount}&policy_profile[term_in_years]=#{term_in_years}"))
        .fetch('policies')
    end
  end
end
