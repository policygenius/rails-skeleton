class QuoteService
  URL = "https://compulife-development.policygenius.com/cgi-bin/cqsl.cgi"
  DEFAULT_PARAMS = {"TEMPLATEFILE"=>"TEMPLATE.HTM",
 "HTEMPLATEFILE"=>"HTEMPLATE.HTM",
 "State"=>"5",
 "BirthMonth"=>"6",
 "Birthday"=>"15",
 "BirthYear"=>"1970",
 "Sex"=>"M",
 "Smoker"=>"N",
 "Health"=>"PP",
 "NewCategory"=>"5",
 "FaceAmount"=>"500000",
 "ModeUsed"=>"M",
 "CqsComparison"=>"+Compare+Now+"}

 def self.get_quote(params)
   new(params).get_quote
 end
 
 def initialize(params)
   @params = params
 end
 
  def get_quote
    parse_html_response
  end
  
  private
  
  def parse_html_response
    doc.css('.offer').map do |html_row|
      [html_row.css('.company').text, html_row.css('.annual_premium').text]
    end
  end
  
  def generate_params
    DEFAULT_PARAMS.merge({"Sex" => gender, "BirthYear" => birthday.year, "Birthday" => birthday.day, "BirthMonth" => birthday.month})
  end
  
  def html
    RestClient.get URL, params: generate_params
  end
  
  def doc
    Nokogiri::HTML(html)
  end
  
  def age
    params[:age].try(:to_i)
  end
  
  def gender
    params[:gender]
  end
  
  def birthday
    birthday = Time.zone.now - age.years
  end
  
  attr_reader :params
end