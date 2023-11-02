module AddressHelper
  def full_address_string(address)
    description = "#{address.street_name}, #{address.number}, "
    description << "#{address.complement}, " if address.complement.present?
    description << "#{address.neighbourhood}, #{address.postal_code}, "
    description << "#{address.city} - #{address.state}"
  end
end
