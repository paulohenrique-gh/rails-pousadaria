class GuestCheckin < ApplicationRecord
  belongs_to :reservation

  validates :guest_name, :document, presence: true
end
