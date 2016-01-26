class QuoteClient

  def initialize(gender)

  end

  def make_api_call
    quotes_html = RestClient.get construct_url
    parse_html(quotes_html)
  end

  def construct_url
    "https://compulife-development.policygenius.com/cgi-bin/cqsl.cgi?TEMPLATEFILE=TEMPLATE.HTM&HTEMPLATEFILE=HTEMPLATE.HTM&State=5&BirthMonth=6&Birthday=15&BirthYear=1970&Sex=M&Smoker=N&Health=PP&NewCategory=5&FaceAmount=500000&ModeUsed=M&CqsComparison=+Compare+Now+"
  end

  def parse_html(html)
    doc = Nokogiri::HTML(html)

    quotes = {}
     doc.css('.offer').each do |offer|
       company_name = offer.css('.company').text
       premium = offer.css('.mode_premium').text
       quotes[company_name] = premium
      #  quotes[offer.css('.company')] = offer.css('.mode-premium')
     end
     
     quotes
  end

end
