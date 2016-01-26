class QuotesController < ApplicationController

  def new
  end

  def create
    quote_client = QuoteClient.new({gender: params[:gender]})
    @quotes = quote_client.make_api_call()
    render :show
  end

end
