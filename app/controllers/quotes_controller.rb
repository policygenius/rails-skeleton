require 'external_services/quote_service'

class QuotesController < ApplicationController
  
  def new
    
  end
  
  def create
    @data = QuoteService.get_quote params.permit(:age, :gender)
  end


  
end