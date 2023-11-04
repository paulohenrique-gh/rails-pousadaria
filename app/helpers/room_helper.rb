module RoomHelper
  def extra_features?(room)
    room.private_bathroom || room.balcony || room.air_conditioning ||
    room.tv || room.closet || room.safe || room.accessibility
  end

  def extra_features_collection(room)
    features = []
    features << 'Banheiro próprio' if room.private_bathroom
    features << 'Varanda' if room.balcony
    features << 'Ar-condicionado' if room.air_conditioning
    features << 'TV' if room.tv
    features << 'Guarda-roupas' if room.closet
    features << 'Cofre' if room.safe
    features << 'Acessível para pessoas com deficiência' if room.accessibility
    features
  end

  def room_availability(room)
    return 'Disponível para reservas' if room.available?
    'Não disponível para reservas'
  end
end
