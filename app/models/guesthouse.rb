class Guesthouse < ApplicationRecord
  belongs_to :address
  belongs_to :user

  validates :brand_name, :corporate_name, :registration_number, :phone_number,
            :email, presence: true

  enum status: { active: 0, inactive: 1 }

  accepts_nested_attributes_for :address

  def pet_policy_description
    return 'Aceita pets' if self.pet_policy
    'Não aceita pets'
  end

  def formatted_checkin_time
    self.checkin_time.strftime('%H:%M')
  end

  def formatted_checkout_time
    self.checkout_time.strftime('%H:%M')
  end
end
