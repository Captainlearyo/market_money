class VendorSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :contact_name, :contact_phone, :credit_accepted

  def credit_accepted
    object.credit_accepted.present? ? object.credit_accepted : false
  end
  
end