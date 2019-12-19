# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_addresses
  accepts_nested_attributes_for :contact_addresses

  validates :name, presence: true
  validates :user_id, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
