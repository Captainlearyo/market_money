class Api::V0::Markets::VendorsController < ApplicationController
  def index
    market = Market.find_by(id: params[:market_id])
    if market
      render json: VendorSerializer.new(market.vendors)
    else
      render json: ErrorSerializer.new(ErrorMessage.new('Market not found', 404)).serialize_json, status: 404
    end
  end
end
