class Room < ApplicationRecord
  belongs_to :guesthouse

  validates :name, :description, :dimension,
            :max_people, :daily_rate, presence: true

  def additional_features_collection(room)
    collection = []
    collection << 'Banheiro próprio' if room.private_bathroom
    collection << 'Varanda' if room.balcony
    collection << 'Ar-condicionado' if room.air_conditioning
    collection << 'TV' if room.tv
    collection << 'Guarda-roupas' if room.closet
    collection << 'Cofre' if room.safe
    collection << 'Acessível para pessoas com deficiência' if room.accessibility
    collection
  end
end
