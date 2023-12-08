class Api::V0::VendorsController < ApplicationController
  def index
    render json: VendorSerializer.new(Vendor.all)
  end

  def show
    begin
      render json: VendorSerializer.new(Vendor.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      render json: ErrorSerializer.new(ErrorMessage.new(error.message, 404)).serialize_json, status: 404
    end
  end

  def create
    vendor = Vendor.new(vendor_params)
    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new(vendor.errors.full_messages.join(', '), 400)).serialize_json, status: :bad_request
    end
  end
  
  def destroy
    vendor = Vendor.find_by(id: params[:id])
  
    if vendor
      vendor.destroy
      render json: {}, status: :no_content
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Vendor not found", 404)).serialize_json, status: :not_found
    end
  end

  def update
    vendor = Vendor.find_by(id: params[:id])
  
    if vendor.nil?
      head :not_found
    else
      if vendor.update(vendor_params)
        render json: VendorSerializer.new(vendor)
      else
        render json: { errors: vendor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  
  
  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

end
