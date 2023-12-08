class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_vendor = MarketVendor.new(market_vendor_params)
    if market_vendor.save
      render json: MarketVendorSerializer.new(market_vendor), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new(market_vendor.errors.full_messages, 404)).serialize_json, status: :not_found
    end
  end
  
  def destroy
    market_vendor = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])
    if market_vendor
      market_vendor.destroy
      render json: {}, status: :no_content
    else
      render json: ErrorSerializer.new(ErrorMessage.new("MarketVendor not found", 404)).serialize_json, status: :not_found
    end
  end

  private

  def market_vendor_params
    params.permit(:market_id, :vendor_id)
  end

end