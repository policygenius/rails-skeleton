class PolicyCacheBuilder
  BASE_URL = 'actuary-staging.policygenius.com/policies?date_of_birth=1980-01-21&gender=male&health_profile[currently_uses_tobacco]=false&health_profile[height_feet]=5&health_profile[height_inches]=8&health_profile[history_of_tobacco_use]=false&health_profile[weight]=180&state_code=TX'
  TERMS = [10, 15, 20, 25, 30]
  COVERAGES = [100_000, 250_000, 500_000, 1_000_000, 5_000_000, 10_000_000]

  class << self
    def run
      File.open(Rails.root.join('config', 'policies.yml'), 'wb') do |file|
        file.write(policies_hash.to_yaml)
      end
    end

    def policies_hash
      TERMS.reduce({}) do |hash, term|
        hash.merge(term => policies_for_term(term))
      end
    end

    def policies_for_term(term)
      COVERAGES.reduce({}) do |hash, coverage|
        hash.merge(coverage => policies_for(term, coverage))
      end
    end

    def policies_for(term_in_years, coverage_amount)
      JSON
        .parse(
          RestClient.get(
            "#{BASE_URL}&policy_profile[coverage_amount]=#{coverage_amount}&policy_profile[term_in_years]=#{term_in_years}",
            'Api-Key-Actuary' => ENV.fetch('ACTUARY_API_KEY')
          )
        )
        .fetch('policies')
    end
  end
end
