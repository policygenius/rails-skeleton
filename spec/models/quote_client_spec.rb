require 'rails_helper'
RSpec.describe "QuoteClient", type: :model do

  let(:quote_client) {QuoteClient.new({gender: "male"})}
  let(:quote_1) { {"United of Omaha Life Insurance Company" => "$67.59"} }
  let(:url) {
    "https://compulife-development.policygenius.com/cgi-bin/cqsl.cgi?TEMPLATEFILE=TEMPLATE.HTM&HTEMPLATEFILE=HTEMPLATE.HTM&State=5&BirthMonth=6&Birthday=15&BirthYear=1970&Sex=M&Smoker=N&Health=PP&NewCategory=5&FaceAmount=500000&ModeUsed=M&CqsComparison=+Compare+Now+"
  }
  let(:raw_quotes) do
    <<-html
    <html>

<head>
   <title>Life Insurance Quotes - PolicyGenius</title>
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <meta name="Author" content="COMPULIFE Software, Inc.">
</head>
<body>
  <h2>Life Insurance Search</h2>
  <dl>
    <dt>Date</dt><dd>January 26th, 2016</dd>
    <dt>Premiums for</dt><dd>Male, Preferred Plus, Non-Smoker</dd>
    <dt>Birthday</dt><dd>June 15th, 1970</dd>
    <dt>Age</dt><dd>45</dd>
    <dt>Age Nearest</dt><dd>46</dd>
    <dt>State</dt><dd>California</dd>
    <dt>Face Amount</dt><dd>$500,000</dd>
  </dl>

  <h3>20 Year Level Term Guaranteed</h3>

  <table width="100%">

    <tr>
      <td>Company Name</td>
      <td>Company Code</td>
      <td>Product Name</td>
      <td>Health Category</td>
      <td>Annual Premium</td>
      <td>Monthly  Premium</td>
      <td>AM Best Rating</td>
    </tr>

        <tr class="offer">      <td class="company">United of Omaha Life Insurance Company</td>      <td class="company_code">UTOM</td>      <td class="product">Term Life Answers 20                    </td>      <td class="health_category">Preferred Plus Non-Tobacco    </td>      <td class="annual_premium">$617.50</td>      <td class="mode_premium">$54.03</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Protective Life Insurance Company</td>      <td class="company_code">PROT</td>      <td class="product">Custom Choice UL - 20 Year No Lapse     </td>      <td class="health_category">Select Preferred Non-Tobacco  </td>      <td class="annual_premium">$642.96</td>      <td class="mode_premium">$55.29</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">American General Life Insurance Company</td>      <td class="company_code">AMGE</td>      <td class="product">Select-a-Term - 20 Year  (Nov 2015)     </td>      <td class="health_category">Preferred Plus Non-Tobacco    </td>      <td class="annual_premium">$649.00</td>      <td class="mode_premium">$56.14</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">Pruco Life Insurance Company</td>      <td class="company_code">PRUC</td>      <td class="product">Term Essential 20 (<250K PruXpress / CA)</td>      <td class="health_category">Preferred Best                </td>      <td class="annual_premium">$625.00</td>      <td class="mode_premium">$56.25</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Banner Life Insurance Company</td>      <td class="company_code">BANN</td>      <td class="product">OPTerm 20 - 20 Year Term                </td>      <td class="health_category">Preferred Plus Non-Smoker</td>      <td class="annual_premium">$644.99</td>      <td class="mode_premium">$56.44</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Savings Bank Life Insurance Co of MA</td>      <td class="company_code">SAVE</td>      <td class="product">T-20/20 - 20 Year Term  (new rates)     </td>      <td class="health_category">Preferred Plus Non-Nicotine   </td>      <td class="annual_premium">$648.99</td>      <td class="mode_premium">$56.46</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Lincoln National Life Insurance Company</td>      <td class="company_code">LNNA</td>      <td class="product">LifeElement (SM) Level Term 20 (2014)   </td>      <td class="health_category">Preferred Plus Non-tobacco    </td>      <td class="annual_premium">$660.00</td>      <td class="mode_premium">$57.75</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Transamerica Life Insurance Company</td>      <td class="company_code">TRAN</td>      <td class="product">Trendsetter Super 20                    </td>      <td class="health_category">Preferred Plus Non-Smoker</td>      <td class="annual_premium">$675.00</td>      <td class="mode_premium">$58.06</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Genworth Life and Annuity Insurance Co</td>      <td class="company_code">GEAN</td>      <td class="product">Colony Term 20                          </td>      <td class="health_category">Preferred Best No Nicotine Use</td>      <td class="annual_premium">$670.00</td>      <td class="mode_premium">$58.63</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">Genworth Life Insurance Company</td>      <td class="company_code">GECA</td>      <td class="product">Colony Term 20                          </td>      <td class="health_category">Preferred Best No Nicotine Use</td>      <td class="annual_premium">$670.00</td>      <td class="mode_premium">$58.63</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">American National Insurance Company</td>      <td class="company_code">AMNT</td>      <td class="product">Signature Term 20                       </td>      <td class="health_category">Preferred Plus Non-tobacco    </td>      <td class="annual_premium">$685.00</td>      <td class="mode_premium">$59.18</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">MetLife Insurance Company USA</td>      <td class="company_code">METL</td>      <td class="product">Guaranteed Level Term 20                </td>      <td class="health_category">Elite Plus Nonsmoker          </td>      <td class="annual_premium">$664.00</td>      <td class="mode_premium">$59.76</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Principal National Life Insurance Co</td>      <td class="company_code">PRIP</td>      <td class="product">20-Year Term (09/2015)                  </td>      <td class="health_category">Super Preferred non-tobacco   </td>      <td class="annual_premium">$685.87</td>      <td class="mode_premium">$60.01</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">ReliaStar Life Insurance Company</td>      <td class="company_code">RELL</td>      <td class="product">TermSmart 20 - 20 Year Term             </td>      <td class="health_category">Super Preferred Non-Tobacco   </td>      <td class="annual_premium">$690.00</td>      <td class="mode_premium">$60.38</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">Transamerica Life Insurance Company</td>      <td class="company_code">TRAN</td>      <td class="product">Trendsetter LB 20                       </td>      <td class="health_category">Preferred Plus Non-Smoker     </td>      <td class="annual_premium">$710.00</td>      <td class="mode_premium">$61.07</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Pruco Life Insurance Company</td>      <td class="company_code">PRUC</td>      <td class="product">Term Elite 20  (<250K PruXpress ONLY/CA)</td>      <td class="health_category">Preferred Best                </td>      <td class="annual_premium">$695.00</td>      <td class="mode_premium">$62.55</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">AXA Equitable Life Insurance Company</td>      <td class="company_code">AXAA</td>      <td class="product">Equitable Term 20  (151X)               </td>      <td class="health_category">Preferred Elite Non-Tobacco   </td>      <td class="annual_premium">$705.00</td>      <td class="mode_premium">$62.87</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Minnesota Life Insurance Company</td>      <td class="company_code">MINM</td>      <td class="product">Advantage Elite Select Life - 20 Year   </td>      <td class="health_category">Preferred Select Non-Tobacco  </td>      <td class="annual_premium">$750.00</td>      <td class="mode_premium">$66.00</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Protective Life Insurance Company</td>      <td class="company_code">PROT</td>      <td class="product">Custom Choice UL - 20 Year No Lapse     </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$771.57</td>      <td class="mode_premium">$66.34</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">American General Life Insurance Company</td>      <td class="company_code">AMGE</td>      <td class="product">Select-a-Term - 20 Year  (Nov 2015)     </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$779.00</td>      <td class="mode_premium">$67.38</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">MetLife Insurance Company USA</td>      <td class="company_code">METL</td>      <td class="product">Guaranteed Level Term 20                </td>      <td class="health_category">Elite Nonsmoker               </td>      <td class="annual_premium">$749.00</td>      <td class="mode_premium">$67.41</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">United of Omaha Life Insurance Company</td>      <td class="company_code">UTOM</td>      <td class="product">Term Life Answers 20                    </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$772.50</td>      <td class="mode_premium">$67.59</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Savings Bank Life Insurance Co of MA</td>      <td class="company_code">SAVE</td>      <td class="product">T-20/20 - 20 Year Term  (new rates)     </td>      <td class="health_category">Preferred Non-Nicotine        </td>      <td class="annual_premium">$778.99</td>      <td class="mode_premium">$67.77</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Minnesota Life Insurance Company</td>      <td class="company_code">MINM</td>      <td class="product">Advantage Elite - 20 Year  (w/ext conv.)</td>      <td class="health_category">Preferred Select Non-Tobacco  </td>      <td class="annual_premium">$772.50</td>      <td class="mode_premium">$67.98</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Banner Life Insurance Company</td>      <td class="company_code">BANN</td>      <td class="product">OPTerm 20 - 20 Year Term                </td>      <td class="health_category">Preferred Non-Smoker</td>      <td class="annual_premium">$778.98</td>      <td class="mode_premium">$68.16</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Lincoln National Life Insurance Company</td>      <td class="company_code">LNNA</td>      <td class="product">LifeElement (SM) Level Term 20 (2014)   </td>      <td class="health_category">Preferred Non-tobacco         </td>      <td class="annual_premium">$786.50</td>      <td class="mode_premium">$68.82</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Transamerica Life Insurance Company</td>      <td class="company_code">TRAN</td>      <td class="product">Trendsetter Super 20                    </td>      <td class="health_category">Preferred Non-Smoker</td>      <td class="annual_premium">$805.00</td>      <td class="mode_premium">$69.24</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Principal National Life Insurance Co</td>      <td class="company_code">PRIP</td>      <td class="product">20-Year Term (09/2015)                  </td>      <td class="health_category">Preferred non-tobacco         </td>      <td class="annual_premium">$791.74</td>      <td class="mode_premium">$69.28</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Genworth Life and Annuity Insurance Co</td>      <td class="company_code">GEAN</td>      <td class="product">Colony Term 20                          </td>      <td class="health_category">Preferred No Nicotine Use     </td>      <td class="annual_premium">$800.00</td>      <td class="mode_premium">$70.00</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">Genworth Life Insurance Company</td>      <td class="company_code">GECA</td>      <td class="product">Colony Term 20                          </td>      <td class="health_category">Preferred No Nicotine Use     </td>      <td class="annual_premium">$800.00</td>      <td class="mode_premium">$70.00</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">Pruco Life Insurance Company</td>      <td class="company_code">PRUC</td>      <td class="product">Term Essential 20 (<250K PruXpress / CA)</td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$790.00</td>      <td class="mode_premium">$71.10</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">American National Insurance Company</td>      <td class="company_code">AMNT</td>      <td class="product">Signature Term 20                       </td>      <td class="health_category">Preferred Non-tobacco         </td>      <td class="annual_premium">$830.00</td>      <td class="mode_premium">$71.71</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">John Hancock Life Insurance Company USA</td>      <td class="company_code">JOHU</td>      <td class="product">Term 20                                 </td>      <td class="health_category">Super Preferred Non-Smoker    </td>      <td class="annual_premium">$790.00</td>      <td class="mode_premium">$72.00</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">MetLife Insurance Company USA</td>      <td class="company_code">METL</td>      <td class="product">Guaranteed Level Term 20                </td>      <td class="health_category">Preferred Nonsmoker           </td>      <td class="annual_premium">$804.00</td>      <td class="mode_premium">$72.36</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Transamerica Life Insurance Company</td>      <td class="company_code">TRAN</td>      <td class="product">Trendsetter LB 20                       </td>      <td class="health_category">Preferred Non-Smoker</td>      <td class="annual_premium">$845.00</td>      <td class="mode_premium">$72.68</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">ReliaStar Life Insurance Company</td>      <td class="company_code">RELL</td>      <td class="product">TermSmart 20 - 20 Year Term             </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$835.00</td>      <td class="mode_premium">$73.06</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">AXA Equitable Life Insurance Company</td>      <td class="company_code">AXAA</td>      <td class="product">Equitable Term 20  (151X)               </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$835.00</td>      <td class="mode_premium">$73.98</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Accordia Life and Annuity Company</td>      <td class="company_code">ACCO</td>      <td class="product">20-Year Level Premium Term              </td>      <td class="health_category">Premier Non-Tobacco           </td>      <td class="annual_premium">$855.00</td>      <td class="mode_premium">$76.10</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">Minnesota Life Insurance Company</td>      <td class="company_code">MINM</td>      <td class="product">Advantage Elite Select Life - 20 Year   </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$890.00</td>      <td class="mode_premium">$78.32</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Pruco Life Insurance Company</td>      <td class="company_code">PRUC</td>      <td class="product">Term Elite 20  (<250K PruXpress ONLY/CA)</td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$880.00</td>      <td class="mode_premium">$79.20</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Minnesota Life Insurance Company</td>      <td class="company_code">MINM</td>      <td class="product">Advantage Elite - 20 Year  (w/ext conv.)</td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$916.70</td>      <td class="mode_premium">$80.67</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">John Hancock Life Insurance Company USA</td>      <td class="company_code">JOHU</td>      <td class="product">Term 20                                 </td>      <td class="health_category">Preferred Non-Smoker</td>      <td class="annual_premium">$895.00</td>      <td class="mode_premium">$81.20</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">John Hancock Life Insurance Company USA</td>      <td class="company_code">JOHU</td>      <td class="product">Term 20 (with CER)                      </td>      <td class="health_category">Super Preferred Non-Smoker    </td>      <td class="annual_premium">$915.00</td>      <td class="mode_premium">$82.95</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">American General Life Insurance Company</td>      <td class="company_code">AMGE</td>      <td class="product">Select-a-Term - 20 Year  (Nov 2015)     </td>      <td class="health_category">Standard Plus Non-Tobacco     </td>      <td class="annual_premium">$1,059.00</td>      <td class="mode_premium">$91.60</td>      <td class="am_best_rating">A</td>    </tr>
        <tr class="offer">      <td class="company">Accordia Life and Annuity Company</td>      <td class="company_code">ACCO</td>      <td class="product">20-Year Level Premium Term              </td>      <td class="health_category">Preferred Non-Tobacco         </td>      <td class="annual_premium">$1,030.00</td>      <td class="mode_premium">$91.67</td>      <td class="am_best_rating">A-</td>    </tr>
        <tr class="offer">      <td class="company">Savings Bank Life Insurance Co of MA</td>      <td class="company_code">SAVE</td>      <td class="product">T-20/20 - 20 Year Term  (new rates)     </td>      <td class="health_category">Select Non-Nicotine           </td>      <td class="annual_premium">$1,058.99</td>      <td class="mode_premium">$92.13</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">John Hancock Life Insurance Company USA</td>      <td class="company_code">JOHU</td>      <td class="product">Term 20 (with CER)                      </td>      <td class="health_category">Preferred Non-Smoker</td>      <td class="annual_premium">$1,020.00</td>      <td class="mode_premium">$92.15</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Transamerica Life Insurance Company</td>      <td class="company_code">TRAN</td>      <td class="product">Trendsetter Super 20                    </td>      <td class="health_category">Standard Plus Non-Smoker      </td>      <td class="annual_premium">$1,075.00</td>      <td class="mode_premium">$92.46</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Banner Life Insurance Company</td>      <td class="company_code">BANN</td>      <td class="product">OPTerm 20 - 20 Year Term                </td>      <td class="health_category">Non-Smoker Plus</td>      <td class="annual_premium">$1,058.98</td>      <td class="mode_premium">$92.66</td>      <td class="am_best_rating">A+</td>    </tr>
        <tr class="offer">      <td class="company">Pruco Life Insurance Company</td>      <td class="company_code">PRUC</td>      <td class="product">Term Essential 20 (<250K PruXpress / CA)</td>      <td class="health_category">Non-smoker Plus               </td>      <td class="annual_premium">$1,030.00</td>      <td class="mode_premium">$92.70</td>      <td class="am_best_rating">A+</td>    </tr>

  </table>
</body>
</html>
    html
  end

  before do
    allow(RestClient).to receive(:get).with(url).and_return(raw_quotes)
  end

  describe "#make_api_call" do
    it 'returns a hash of companies and their quotes' do

      expect(quote_client.make_api_call).to match hash_including(quote_1)
    end
  end

end
