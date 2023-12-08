class Api::V0::Markets::NearestAtmsController < ApplicationController
  def index
    market = Market.find(params[:market_id])
    if market
      atms = SearchFacade.nearest_atm(market[:lat], market[:lon])
      render json: AtmSerializer.new(atms), status: 200
    else
      render json: ErrorSerializer.new(ErrorMessage.new("The market you are looking for does not exist", 404)).serialize_json, status: :not_found
    end
  end
end