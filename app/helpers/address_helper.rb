module AddressHelper
  def full_address_string(address)
    [address.street_name, address.number, address.complement,
    address.neighbourhood, address.postal_code,
    "#{address.city} - #{address.state}"].compact.join(', ')
  end
end
