class Api::V0::MarketsController < ApplicationController
  def index
    render json: MarketSerializer.new(Market.all)
  end

  def show
    begin
      render json: MarketSerializer.new(Market.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.new(ErrorMessage.new(error.message, 404)).serialize_json, status: 404
    end
  end

  # def show
  #   market = Market.find_by(id: params[:id])
    
  #   if market
  #     render json: MarketSerializer.new(market)
  #   else
  #     render json: { errors: 'Not Found' }, status: :not_found
  #   end
  # end

  
  def nearest_atms(lat, lon)
    def index
      if Market.exists?(params[:market_id])
        market = Market.find(params[:market_id])
        facade = SearchFacade.new
        results = facade.nearest_atm(market[:lat], market[:lon])
        render json: AtmSerializer.new(results), status: 200
      else
        render json: {errors: "The market you are looking for does not exist"}, status: 404
      end
    end
  end
end