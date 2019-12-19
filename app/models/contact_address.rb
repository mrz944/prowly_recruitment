class ContactAddress < ApplicationRecord
  belongs_to :contact

  validates :city, presence: true
end
