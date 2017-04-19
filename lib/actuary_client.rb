class ActuaryClient
  def self.fetch_policies(term_in_years:, coverage_amount:)
    hash = YAML.load_file(Rails.root.join('config', 'policies.yml'))
    term = nil

    begin
      term = hash.fetch(term_in_years);
    rescue
      fail "Invalid value for term_in_years: #{term_in_years} (#{term_in_years.class.name})"
    end

    begin
      term.fetch(coverage_amount);
    rescue
      fail "Invalid value for coverage_amount: #{coverage_amount} (#{coverage_amount.class.name})}"
    end
  end
end
